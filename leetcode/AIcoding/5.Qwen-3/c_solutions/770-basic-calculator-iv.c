#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

typedef struct {
    char *token;
    int type; // 0: number, 1: operator, 2: parenthesis
} Token;

typedef struct {
    char **tokens;
    int size;
} TokenList;

TokenList* parse_expression(char *s);
char* evaluate(char *s, char **restricted);
char* get_token(char **s);
int is_operator(char c);
int precedence(char op);
void apply_operator(char **result, char *op, char *b, char *a);
char* add(char *a, char *b);
char* subtract(char *a, char *b);
char* multiply(char *a, char *b);
char* parse_number(char **s);
char* simplify(char *expr, char **restricted);
char* combine_terms(char *expr);
char* parse_term(char *term);
char** split_terms(char *expr);
char* format_result(char **terms, int count);

TokenList* parse_expression(char *s) {
    TokenList *tokens = (TokenList*)malloc(sizeof(TokenList));
    tokens->size = 0;
    tokens->tokens = NULL;
    char *p = s;
    while (*p) {
        if (isspace(*p)) {
            p++;
            continue;
        }
        if (isdigit(*p)) {
            char *num = parse_number(&p);
            tokens->tokens = (char**)realloc(tokens->tokens, (tokens->size + 1) * sizeof(char*));
            tokens->tokens[tokens->size++] = num;
        } else if (*p == '(' || *p == ')') {
            tokens->tokens = (char**)realloc(tokens->tokens, (tokens->size + 1) * sizeof(char*));
            tokens->tokens[tokens->size++] = strdup(&*p);
            p++;
        } else if (is_operator(*p)) {
            tokens->tokens = (char**)realloc(tokens->tokens, (tokens->size + 1) * sizeof(char*));
            tokens->tokens[tokens->size++] = strdup(&*p);
            p++;
        } else {
            p++;
        }
    }
    return tokens;
}

char* evaluate(char *s, char **restricted) {
    TokenList *tokens = parse_expression(s);
    char **output = (char**)malloc(100 * sizeof(char*));
    int output_size = 0;
    char **operators = (char**)malloc(100 * sizeof(char*));
    int op_size = 0;
    for (int i = 0; i < tokens->size; i++) {
        char *token = tokens->tokens[i];
        if (isdigit(token[0])) {
            output[output_size++] = token;
        } else if (token[0] == '(') {
            operators[op_size++] = token;
        } else if (token[0] == ')') {
            while (op_size > 0 && operators[op_size - 1][0] != '(') {
                char *op = operators[--op_size];
                char *b = output[--output_size];
                char *a = output[--output_size];
                char *res = NULL;
                if (op[0] == '+') res = add(a, b);
                else if (op[0] == '-') res = subtract(a, b);
                else if (op[0] == '*') res = multiply(a, b);
                output[output_size++] = res;
            }
            free(operators[--op_size]);
        } else {
            while (op_size > 0 && is_operator(operators[op_size - 1][0]) && precedence(operators[op_size - 1][0]) >= precedence(token[0])) {
                char *op = operators[--op_size];
                char *b = output[--output_size];
                char *a = output[--output_size];
                char *res = NULL;
                if (op[0] == '+') res = add(a, b);
                else if (op[0] == '-') res = subtract(a, b);
                else if (op[0] == '*') res = multiply(a, b);
                output[output_size++] = res;
            }
            operators[op_size++] = token;
        }
    }
    while (op_size > 0) {
        char *op = operators[--op_size];
        char *b = output[--output_size];
        char *a = output[--output_size];
        char *res = NULL;
        if (op[0] == '+') res = add(a, b);
        else if (op[0] == '-') res = subtract(a, b);
        else if (op[0] == '*') res = multiply(a, b);
        output[output_size++] = res;
    }
    char *result = output[0];
    for (int i = 1; i < output_size; i++) {
        free(output[i]);
    }
    free(output);
    free(operators);
    for (int i = 0; i < tokens->size; i++) {
        free(tokens->tokens[i]);
    }
    free(tokens->tokens);
    free(tokens);
    return result;
}

char* get_token(char **s) {
    char *token = (char*)malloc(2);
    token[0] = **s;
    token[1] = '\0';
    (*s)++;
    return token;
}

int is_operator(char c) {
    return c == '+' || c == '-' || c == '*' || c == '/';
}

int precedence(char op) {
    if (op == '+' || op == '-') return 1;
    if (op == '*' || op == '/') return 2;
    return 0;
}

void apply_operator(char **result, char *op, char *b, char *a) {
    if (op[0] == '+') {
        *result = add(a, b);
    } else if (op[0] == '-') {
        *result = subtract(a, b);
    } else if (op[0] == '*') {
        *result = multiply(a, b);
    }
}

char* parse_number(char **s) {
    char *num = (char*)malloc(1);
    num[0] = '\0';
    while (isdigit(**s)) {
        num = (char*)realloc(num, strlen(num) + 2);
        strcat(num, **s);
        (*s)++;
    }
    return num;
}

char* simplify(char *expr, char **restricted) {
    char *simplified = (char*)malloc(1);
    simplified[0] = '\0';
    char *token = strtok(expr, " ");
    while (token) {
        int is_restricted = 0;
        for (int i = 0; restricted[i]; i++) {
            if (strcmp(token, restricted[i]) == 0) {
                is_restricted = 1;
                break;
            }
        }
        if (!is_restricted) {
            simplified = (char*)realloc(simplified, strlen(simplified) + strlen(token) + 2);
            strcat(simplified, token);
            strcat(simplified, " ");
        }
        token = strtok(NULL, " ");
    }
    return simplified;
}

char* combine_terms(char *expr) {
    char **terms = split_terms(expr);
    char **combined = (char**)malloc(100 * sizeof(char*));
    int combined_size = 0;
    for (int i = 0; terms[i]; i++) {
        char *term = terms[i];
        char *parsed = parse_term(term);
        if (parsed) {
            combined[combined_size++] = parsed;
        }
    }
    return format_result(combined, combined_size);
}

char* parse_term(char *term) {
    char *coeff = (char*)malloc(1);
    coeff[0] = '\0';
    char *var = (char*)malloc(1);
    var[0] = '\0';
    char *p = term;
    while (*p && *p != 'x') {
        coeff = (char*)realloc(coeff, strlen(coeff) + 2);
        strcat(coeff, p);
        p++;
    }
    if (*p == 'x') {
        p++;
        if (*p == '^') {
            p++;
            char *exp = (char*)malloc(1);
            exp[0] = '\0';
            while (*p && *p != 'x') {
                exp = (char*)realloc(exp, strlen(exp) + 2);
                strcat(exp, p);
                p++;
            }
            if (*p == 'x') {
                var = (char*)realloc(var, strlen(var) + 2);
                strcat(var, "x");
                var = (char*)realloc(var, strlen(var) + strlen(exp) + 2);
                strcat(var, "^");
                strcat(var, exp);
            }
        } else {
            var = (char*)realloc(var, strlen(var) + 2);
            strcat(var, "x");
        }
    }
    if (strlen(coeff) == 0) {
        coeff = "1";
    }
    char *result = (char*)malloc(strlen(coeff) + strlen(var) + 2);
    sprintf(result, "%s%s", coeff, var);
    free(coeff);
    free(var);
    return result;
}

char** split_terms(char *expr) {
    char **terms = (char**)