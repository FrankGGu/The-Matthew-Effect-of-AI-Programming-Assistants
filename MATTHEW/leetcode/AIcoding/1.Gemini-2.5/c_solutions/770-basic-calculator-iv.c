#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <stdbool.h>
#include <ctype.h> // For isdigit, isalpha

#define MAX_EXPR_LEN 1000 // Max length of the input expression
#define MAX_VAR_NAME_LEN 20 // Max length of a variable name (e.g., "alpha")
#define INITIAL_TERMS_CAPACITY 16 // Initial capacity for polynomial terms, will reallocate
#define INITIAL_VARS_CAPACITY 4 // Initial capacity for variables in a term, will reallocate

typedef struct {
    char** vars;
    int count;
    int capacity;
} VarList;

typedef struct {
    int coeff;
    VarList var_list;
} Term;

typedef struct {
    Term* terms;
    int count;
    int capacity;
} Polynomial;

char* g_expr;
int g_pos;
char** g_eval_map_names; // Array of variable names from evalvars
int* g_eval_map_values;  // Array of values from evalints
int g_eval_map_size;     // Size of evalvars/evalints

VarList var_list_create() {
    VarList vl;
    vl.vars = (char**)malloc(INITIAL_VARS_CAPACITY * sizeof(char*));
    vl.count = 0;
    vl.capacity = INITIAL_VARS_CAPACITY;
    return vl;
}

void var_list_add(VarList* vl, const char* var_name) {
    if (vl->count == vl->capacity) {
        vl->capacity *= 2;
        vl->vars = (char**)realloc(vl->vars, vl->capacity * sizeof(char*));
    }
    vl->vars[vl->count] = strdup(var_name);
    vl->count++;
}

VarList var_list_copy(const VarList* src) {
    VarList dest = var_list_create();
    for (int i = 0; i < src->count; i++) {
        var_list_add(&dest, src->vars[i]);
    }
    return dest;
}

void var_list_free(VarList* vl) {
    if (vl == NULL) return;
    for (int i = 0; i < vl->count; i++) {
        free(vl->vars[i]);
    }
    free(vl->vars);
    vl->vars = NULL;
    vl->count = 0;
    vl->capacity = 0;
}

int compare_var_names(const void* a, const void* b) {
    return strcmp(*(const char**)a, *(const char**)b);
}

void var_list_sort(VarList* vl) {
    if (vl && vl->count > 1) {
        qsort(vl->vars, vl->count, sizeof(char*), compare_var_names);
    }
}

int var_list_compare(const VarList* vl1, const VarList* vl2) {
    if (vl1->count != vl2->count) {
        return vl1->count - vl2->count;
    }
    for (int i = 0; i < vl1->count; i++) {
        int cmp = strcmp(vl1->vars[i], vl2->vars[i]);
        if (cmp != 0) {
            return cmp;
        }
    }
    return 0;
}

Polynomial poly_create() {
    Polynomial p;
    p.terms = (Term*)malloc(INITIAL_TERMS_CAPACITY * sizeof(Term));
    p.count = 0;
    p.capacity = INITIAL_TERMS_CAPACITY;
    return p;
}

void poly_add_term(Polynomial* p, int coeff, VarList vl) {
    if (coeff == 0) {
        var_list_free(&vl);
        return;
    }

    var_list_sort(&vl);

    for (int i = 0; i < p->count; i++) {
        if (var_list_compare(&p->terms[i].var_list, &vl) == 0) {
            p->terms[i].coeff += coeff;
            var_list_free(&vl);
            if (p->terms[i].coeff == 0) {
                var_list_free(&p->terms[i].var_list);
                p->terms[i] = p->terms[p->count - 1];
                p->count--;
                i--; 
            }
            return;
        }
    }

    if (p->count == p->capacity) {
        p->capacity *= 2;
        p->terms = (Term*)realloc(p->terms, p->capacity * sizeof(Term));
    }
    p->terms[p->count].coeff = coeff;
    p->terms[p->count].var_list = vl;
    p->count++;
}

void poly_free(Polynomial* p) {
    if (p == NULL) return;
    for (int i = 0; i < p->count; i++) {
        var_list_free(&p->terms[i].var_list);
    }
    free(p->terms);
    p->terms = NULL;
    p->count = 0;
    p->capacity = 0;
}

Polynomial poly_add(const Polynomial* p1, const Polynomial* p2) {
    Polynomial result = poly_create();
    for (int i = 0; i < p1->count; i++) {
        poly_add_term(&result, p1->terms[i].coeff, var_list_copy(&p1->terms[i].var_list));
    }
    for (int i = 0; i < p2->count; i++) {
        poly_add_term(&result, p2->terms[i].coeff, var_list_copy(&p2->terms[i].var_list));
    }
    return result;
}

Polynomial poly_sub(const Polynomial* p1, const Polynomial* p2) {
    Polynomial result = poly_create();
    for (int i = 0; i < p1->count; i++) {
        poly_add_term(&result, p1->terms[i].coeff, var_list_copy(&p1->terms[i].var_list));
    }
    for (int i = 0; i < p2->count; i++) {
        poly_add_term(&result, -p2->terms[i].coeff, var_list_copy(&p2->terms[i].var_list));
    }
    return result;
}

Polynomial poly_mult(const Polynomial* p1, const Polynomial* p2) {
    Polynomial result = poly_create();
    for (int i = 0; i < p1->count; i++) {
        for (int j = 0; j < p2->count; j++) {
            int new_coeff = p1->terms[i].coeff * p2->terms[j].coeff;
            VarList new_vl = var_list_create();
            for (int k = 0; k < p1->terms[i].var_list.count; k++) {
                var_list_add(&new_vl, p1->terms[i].var_list.vars[k]);
            }
            for (int k = 0; k < p2->terms[j].var_list.count; k++) {
                var_list_add(&new_vl, p2->terms[j].var_list.vars[k]);
            }
            poly_add_term(&result, new_coeff, new_vl);
        }
    }
    return result;
}

Polynomial parse_expression();
Polynomial parse_term();
Polynomial parse_factor();

void skip_whitespace() {
    while (g_expr[g_pos] == ' ') {
        g_pos++;
    }
}

Polynomial parse_factor() {
    skip_whitespace();
    Polynomial p = poly_create();

    if (g_expr[g_pos] == '(') {
        g_pos++;
        Polynomial inner_expr = parse_expression();
        skip_whitespace();
        g_pos++;
        return inner_expr;
    } else if (isdigit(g_expr[g_pos])) {
        int num = 0;
        while (isdigit(g_expr[g_pos])) {
            num = num * 10 + (g_expr[g_pos] - '0');
            g_pos++;
        }
        VarList vl = var_list_create();
        poly_add_term(&p, num, vl);
        return p;
    } else if (isalpha(g_expr[g_pos])) {
        char var_name_buf[MAX_VAR_NAME_LEN + 1];
        int var_name_idx = 0;
        while (isalpha(g_expr[g_pos]) && var_name_idx < MAX_VAR_NAME_LEN) {
            var_name_buf[var_name_idx++] = g_expr[g_pos];
            g_pos++;
        }
        var_name_buf[var_name_idx] = '\0';

        int value = -1;
        for (int i = 0; i < g_eval_map_size; i++) {
            if (strcmp(g_eval_map_names[i], var_name_buf) == 0) {
                value = g_eval_map_values[i];
                break;
            }
        }

        if (value != -1) {
            VarList vl = var_list_create();
            poly_add_term(&p, value, vl);
        } else {
            VarList vl = var_list_create();
            var_list_add(&vl, var_name_buf);
            poly_add_term(&p, 1, vl);
        }
        return p;
    }
    return p;
}

Polynomial parse_term() {
    Polynomial p = parse_factor();
    skip_whitespace();
    while (g_expr[g_pos] == '*') {
        g_pos++;
        Polynomial next_factor = parse_factor();
        Polynomial temp = poly_mult(&p, &next_factor);
        poly_free(&p);
        poly_free(&next_factor);
        p = temp;
        skip_whitespace();
    }
    return p;
}

Polynomial parse_expression() {
    Polynomial p = parse_term();
    skip_whitespace();
    while (g_expr[g_pos] == '+' || g_expr[g_pos] == '-') {
        char op = g_expr[g_pos];
        g_pos++;
        Polynomial next_term = parse_term();
        Polynomial temp;
        if (op == '+') {
            temp = poly_add(&p, &next_term);
        } else {
            temp = poly_sub(&p, &next_term);
        }
        poly_free(&p);
        poly_free(&next_term);
        p = temp;
        skip_whitespace();
    }
    return p;
}

int compare_terms(const void* a, const void* b) {
    const Term* t1 = (const Term*)a;
    const Term* t2 = (const Term*)b;

    if (t1->var_list.count != t2->var_list.count) {
        return t2->var_list.count - t1->var_list.count;
    }

    return var_list_compare(&t1->var_list, &t2->var_list);
}

char** basicCalculatorIV(char* expression, char** evalvars, int evalvarsSize, int* evalints, int* returnSize) {
    g_expr = expression;
    g_pos = 0;

    g_eval_map_names = evalvars;
    g_eval_map_values = evalints;
    g_eval_map_size = evalvarsSize;

    Polynomial final_poly = parse_expression();

    qsort(final_poly.terms, final_poly.count, sizeof(Term), compare_terms);

    char** result_strings = NULL;
    *returnSize = 0;

    char term_buf[256]; 

    for (int i = 0; i < final_poly.count; i++) {
        if (final_poly.terms[i].coeff == 0) {
            continue; 
        }

        int offset = 0;
        offset += sprintf(term_buf + offset, "%d", final_poly.terms[i].coeff);
        for (int j = 0; j < final_poly.terms[i].var_list.count; j++) {
            offset += sprintf(term_buf + offset, "*%s", final_poly.terms[i].var_list.vars[j]);
        }

        result_strings = (char**)realloc(result_strings, ((*returnSize) + 1) * sizeof(char*));
        result_strings[*returnSize] = strdup(term_buf);
        (*returnSize)++;
    }

    if (*returnSize == 0) {
        result_strings = (char**)realloc(result_strings, sizeof(char*));
        result_strings[0] = strdup("0");
        (*returnSize) = 1;
    }

    poly_free(&final_poly);

    return result_strings;
}