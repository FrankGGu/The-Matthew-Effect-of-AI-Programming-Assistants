#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_SCOPE 100
#define MAX_VARS 100

typedef struct {
    char name[10];
    int value;
} Var;

typedef struct {
    Var vars[MAX_VARS];
    int count;
} Scope;

Scope scopes[MAX_SCOPE];
int scope_top = -1;

void push_scope() {
    scope_top++;
    scopes[scope_top].count = 0;
}

void pop_scope() {
    scope_top--;
}

int find_var(char* name) {
    for (int i = scope_top; i >= 0; i--) {
        for (int j = 0; j < scopes[i].count; j++) {
            if (strcmp(scopes[i].vars[j].name, name) == 0) {
                return scopes[i].vars[j].value;
            }
        }
    }
    return -1;
}

void set_var(char* name, int value) {
    for (int i = scope_top; i >= 0; i--) {
        for (int j = 0; j < scopes[i].count; j++) {
            if (strcmp(scopes[i].vars[j].name, name) == 0) {
                scopes[i].vars[j].value = value;
                return;
            }
        }
    }

    if (scopes[scope_top].count < MAX_VARS) {
        strcpy(scopes[scope_top].vars[scopes[scope_top].count].name, name);
        scopes[scope_top].vars[scopes[scope_top].count].value = value;
        scopes[scope_top].count++;
    }
}

int is_number(char* s) {
    if (*s == '-' || isdigit(*s)) {
        char* p = s + (*s == '-');
        while (*p) {
            if (!isdigit(*p)) return 0;
            p++;
        }
        return 1;
    }
    return 0;
}

int evaluate(char* expression, int* idx) {
    if (*expression == '(') {
        (*idx)++;
        while (expression[*idx] == ' ') (*idx)++;

        if (strncmp(expression + *idx, "let", 3) == 0) {
            *idx += 3;
            push_scope();

            while (1) {
                while (expression[*idx] == ' ') (*idx)++;
                if (expression[*idx] == '(') {
                    int result = evaluate(expression, idx);
                    pop_scope();
                    return result;
                }

                char var_name[10] = {0};
                int var_idx = 0;
                while (expression[*idx] != ' ' && expression[*idx] != ')') {
                    var_name[var_idx++] = expression[(*idx)++];
                }

                if (expression[*idx] == ')') {
                    int result;
                    if (is_number(var_name)) {
                        result = atoi(var_name);
                    } else {
                        result = find_var(var_name);
                    }
                    pop_scope();
                    return result;
                }

                while (expression[*idx] == ' ') (*idx)++;

                int value = evaluate(expression, idx);
                set_var(var_name, value);

                while (expression[*idx] == ' ') (*idx)++;
                if (expression[*idx] == ')') {
                    pop_scope();
                    return value;
                }
            }
        }
        else if (strncmp(expression + *idx, "add", 3) == 0) {
            *idx += 3;
            while (expression[*idx] == ' ') (*idx)++;
            int a = evaluate(expression, idx);
            while (expression[*idx] == ' ') (*idx)++;
            int b = evaluate(expression, idx);
            (*idx)++;
            return a + b;
        }
        else if (strncmp(expression + *idx, "mult", 4) == 0) {
            *idx += 4;
            while (expression[*idx] == ' ') (*idx)++;
            int a = evaluate(expression, idx);
            while (expression[*idx] == ' ') (*idx)++;
            int b = evaluate(expression, idx);
            (*idx)++;
            return a * b;
        }
    }
    else {
        char token[10] = {0};
        int token_idx = 0;
        while (expression[*idx] != ' ' && expression[*idx] != ')') {
            token[token_idx++] = expression[(*idx)++];
        }

        if (is_number(token)) {
            return atoi(token);
        } else {
            return find_var(token);
        }
    }
    return 0;
}

int evaluateExpression(char* expression) {
    int idx = 0;
    scope_top = -1;
    return evaluate(expression, &idx);
}