#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* var;
    int val;
} Variable;

typedef struct {
    char* expr;
    int len;
    int pos;
} Expression;

int find_variable(Variable* variables, int count, char* var) {
    for (int i = 0; i < count; i++) {
        if (strcmp(variables[i].var, var) == 0) {
            return i;
        }
    }
    return -1;
}

int eval(char* expression, char** evalvars, int* evalints, int evalvarsSize, char*** result, int* resultSize) {
    Variable variables[evalvarsSize];
    for (int i = 0; i < evalvarsSize; i++) {
        variables[i].var = evalvars[i];
        variables[i].val = evalints[i];
    }

    Expression expr = {expression, strlen(expression), 0};

    char* tokens[1000];
    int token_count = 0;

    char* token = strtok(expression, " ");
    while(token != NULL){
        tokens[token_count++] = token;
        token = strtok(NULL, " ");
    }

    if(token_count == 1){
        int var_index = find_variable(variables, evalvarsSize, tokens[0]);
        if (var_index != -1) {
            return variables[var_index].val;
        } else {
             *result = (char**)malloc(sizeof(char*));
                (*result)[0] = strdup(tokens[0]);
                *resultSize = 1;
                return 0;
        }
    }

    *result = (char**)malloc(sizeof(char*));
    (*result)[0] = strdup(expression);
    *resultSize = 1;

    return 0;
}