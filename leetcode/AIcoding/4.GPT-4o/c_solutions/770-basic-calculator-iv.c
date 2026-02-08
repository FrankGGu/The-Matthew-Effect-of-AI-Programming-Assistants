#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

typedef struct {
    char* key;
    int value;
} KeyValue;

typedef struct {
    KeyValue* items;
    int size;
} Map;

Map* createMap() {
    Map* map = (Map*)malloc(sizeof(Map));
    map->items = (KeyValue*)malloc(256 * sizeof(KeyValue));
    map->size = 0;
    return map;
}

void insert(Map* map, char* key, int value) {
    for (int i = 0; i < map->size; i++) {
        if (strcmp(map->items[i].key, key) == 0) {
            map->items[i].value = value;
            return;
        }
    }
    map->items[map->size].key = key;
    map->items[map->size].value = value;
    map->size++;
}

int get(Map* map, char* key) {
    for (int i = 0; i < map->size; i++) {
        if (strcmp(map->items[i].key, key) == 0) {
            return map->items[i].value;
        }
    }
    return 0;
}

int calculate(char* expression, Map* variables) {
    int len = strlen(expression);
    int stack[len];
    int top = -1;
    int num = 0;
    char op = '+';

    for (int i = 0; i <= len; i++) {
        char c = expression[i];
        if (isdigit(c)) {
            num = num * 10 + (c - '0');
        } else if (isalpha(c)) {
            char var[2] = {c, '\0'};
            num = get(variables, var);
        }

        if ((c == ' ' && i < len) || (c != ' ' && c != '\0' && c != '+' && c != '-' && c != '*' && c != '/')) {
            continue;
        }

        if (op == '+') {
            stack[++top] = num;
        } else if (op == '-') {
            stack[++top] = -num;
        } else if (op == '*') {
            stack[top] *= num;
        } else if (op == '/') {
            stack[top] /= num;
        }

        op = c;
        num = 0;
    }

    int result = 0;
    for (int i = 0; i <= top; i++) {
        result += stack[i];
    }
    return result;
}

char** split(char* s, int* returnSize) {
    char** result = malloc(100 * sizeof(char*));
    char* token = strtok(s, " ");
    int size = 0;
    while (token) {
        result[size++] = token;
        token = strtok(NULL, " ");
    }
    *returnSize = size;
    return result;
}

char** basicCalculatorIV(char* expression, char** evalvars, int evalvarsSize, int* returnSize) {
    Map* variables = createMap();
    for (int i = 0; i < evalvarsSize; i++) {
        char* var = evalvars[i];
        int value = atoi(var + strlen(var) - 1); // Simple conversion
        insert(variables, var, value);
    }

    int size;
    char** tokens = split(expression, &size);
    int result = calculate(tokens[0], variables);

    char* resStr = malloc(20);
    sprintf(resStr, "%d", result);
    char** output = malloc(sizeof(char*) * 1);
    output[0] = resStr;
    *returnSize = 1;

    free(tokens);
    free(variables->items);
    free(variables);
    return output;
}