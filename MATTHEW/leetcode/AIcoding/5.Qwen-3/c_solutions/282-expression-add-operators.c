#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char **data;
    int size;
    int capacity;
} StringList;

void addString(StringList *list, const char *str) {
    if (list->size == list->capacity) {
        list->capacity = (list->capacity == 0) ? 1 : list->capacity * 2;
        list->data = (char **)realloc(list->data, list->capacity * sizeof(char *));
    }
    list->data[list->size++] = strdup(str);
}

void freeStringList(StringList *list) {
    for (int i = 0; i < list->size; i++) {
        free(list->data[i]);
    }
    free(list->data);
}

char **addOperators(char *num, int target, int *returnSize) {
    StringList result = {NULL, 0, 0};
    int n = strlen(num);

    void dfs(int index, long prev, long curr, char *path, int pathLen, int isNegative) {
        if (index == n) {
            if (curr == target) {
                path[pathLen] = '\0';
                addString(&result, path);
            }
            return;
        }

        char temp[20];
        int len = 0;
        long numVal = 0;

        for (int i = index; i < n; i++) {
            if (i > index && num[index] == '0') break;
            numVal = numVal * 10 + (num[i] - '0');
            len = sprintf(temp, "%ld", numVal);
            if (isNegative) {
                char op = (prev < 0) ? '+' : '-';
                path[pathLen] = op;
                pathLen++;
            }
            memcpy(path + pathLen, temp, len);
            pathLen += len;

            if (i == n - 1) {
                dfs(i + 1, curr + prev, 0, path, pathLen, 0);
            } else {
                path[pathLen] = '+';
                dfs(i + 1, curr + prev, numVal, path, pathLen + 1, 1);
                path[pathLen] = '-';
                dfs(i + 1, curr + prev, -numVal, path, pathLen + 1, 1);
                path[pathLen] = '*';
                dfs(i + 1, curr, prev * numVal, path, pathLen + 1, 1);
            }

            pathLen -= len;
            if (isNegative) {
                pathLen--;
            }
        }
    }

    char *buffer = (char *)malloc((n + 1) * sizeof(char));
    dfs(0, 0, 0, buffer, 0, 0);
    free(buffer);

    *returnSize = result.size;
    return result.data;
}