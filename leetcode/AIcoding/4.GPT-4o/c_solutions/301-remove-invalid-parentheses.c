#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef struct {
    char** data;
    int size;
    int capacity;
} Set;

void initSet(Set* set, int capacity) {
    set->data = (char**)malloc(capacity * sizeof(char*));
    set->size = 0;
    set->capacity = capacity;
}

void freeSet(Set* set) {
    for (int i = 0; i < set->size; i++) {
        free(set->data[i]);
    }
    free(set->data);
}

void addToSet(Set* set, char* str) {
    if (set->size >= set->capacity) {
        set->capacity *= 2;
        set->data = (char**)realloc(set->data, set->capacity * sizeof(char*));
    }
    set->data[set->size++] = strdup(str);
}

bool isValid(const char* s) {
    int balance = 0;
    for (int i = 0; s[i]; i++) {
        if (s[i] == '(') balance++;
        else if (s[i] == ')') balance--;
        if (balance < 0) return false;
    }
    return balance == 0;
}

void dfs(const char* s, int last_i, int last_j, char* res, int index, Set* result) {
    if (last_j == 0 && isValid(s)) {
        addToSet(result, res);
        return;
    }

    for (int i = last_i; i < strlen(s); i++) {
        if (i != last_i && s[i] == s[i - 1]) continue;
        if (s[i] == '(' || s[i] == ')') {
            char* new_res = strdup(res);
            new_res[index] = '\0';
            dfs(s, i, last_j - 1, new_res, index, result);
            free(new_res);
        }
        res[index] = s[i];
        dfs(s, i + 1, last_j, res, index + 1, result);
    }
}

char** removeInvalidParentheses(char* s, int* returnSize) {
    int left = 0, right = 0;
    for (int i = 0; s[i]; i++) {
        if (s[i] == '(') left++;
        if (s[i] == ')') {
            if (left == 0) right++;
            else left--;
        }
    }

    Set result;
    initSet(&result, 10);
    char* res = (char*)malloc(strlen(s) + 1);
    dfs(s, 0, left + right, res, 0, &result);
    free(res);

    *returnSize = result.size;
    return result.data;
}