#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef struct {
    char **arr;
    int size;
    int capacity;
} StringSet;

void initStringSet(StringSet *set) {
    set->size = 0;
    set->capacity = 10;
    set->arr = malloc(set->capacity * sizeof(char *));
}

void addToStringSet(StringSet *set, char *str) {
    if (set->size == set->capacity) {
        set->capacity *= 2;
        set->arr = realloc(set->arr, set->capacity * sizeof(char *));
    }
    set->arr[set->size++] = strdup(str);
}

int cmp(const void *a, const void *b) {
    return strcmp(*(const char **)a, *(const char **)b);
}

char **braceExpansionII(char *expression, int *returnSize) {
    StringSet set;
    initStringSet(&set);
    int n = strlen(expression);
    char stack[50][50];
    int top = -1;

    for (int i = 0; i < n; i++) {
        if (expression[i] == '{') {
            if (top != -1) {
                strcpy(stack[top + 1], stack[top]);
            }
            top++;
            strcpy(stack[top], "");
        } else if (expression[i] == '}') {
            char *temp = strdup(stack[top]);
            char *token = strtok(temp, ",");
            while (token) {
                addToStringSet(&set, token);
                token = strtok(NULL, ",");
            }
            free(temp);
            top--;
        } else if (expression[i] == ',') {
            continue;
        } else {
            strncat(stack[top], (char[]){expression[i], '\0'}, 1);
        }
    }

    char **finalSet = malloc(set.size * sizeof(char *));
    for (int i = 0; i < set.size; i++) {
        finalSet[i] = set.arr[i];
    }
    qsort(finalSet, set.size, sizeof(char *), cmp);
    *returnSize = set.size;

    free(set.arr);
    return finalSet;
}