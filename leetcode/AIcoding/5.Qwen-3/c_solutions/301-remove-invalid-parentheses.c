#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *data;
    int size;
} StringList;

void freeStringList(StringList *list) {
    for (int i = 0; i < list->size; i++) {
        free(list->data[i]);
    }
    free(list->data);
    free(list);
}

StringList *createStringList(int capacity) {
    StringList *list = (StringList *)malloc(sizeof(StringList));
    list->data = (char **)malloc(capacity * sizeof(char *));
    list->size = 0;
    return list;
}

void addToStringList(StringList *list, char *str) {
    list->data[list->size++] = str;
}

char **removeInvalidParentheses(char *s, int *returnSize) {
    int n = strlen(s);
    int minRemovals = n;
    char **result = NULL;
    *returnSize = 0;

    char *queue[10000];
    int front = 0, rear = 0;
    int visited[10000] = {0};
    int level = 0;

    queue[rear++] = strdup(s);

    while (front < rear) {
        int size = rear - front;
        for (int i = 0; i < size; i++) {
            char *current = queue[front + i];
            int openCount = 0, closeCount = 0;
            int valid = 1;
            for (int j = 0; j < strlen(current); j++) {
                if (current[j] == '(') openCount++;
                else if (current[j] == ')') {
                    closeCount++;
                    if (closeCount > openCount) {
                        valid = 0;
                        break;
                    }
                }
            }
            if (valid && openCount == closeCount) {
                result = (char **)realloc(result, (*returnSize + 1) * sizeof(char *));
                result[*returnSize] = current;
                (*returnSize)++;
                continue;
            }
            if (valid) {
                free(current);
                continue;
            }

            for (int j = 0; j < strlen(current); j++) {
                if (current[j] == '(' || current[j] == ')') {
                    char *next = (char *)malloc(strlen(current) * sizeof(char) + 1);
                    strncpy(next, current, j);
                    strcpy(next + j, current + j + 1);
                    if (!visited[next]) {
                        visited[next] = 1;
                        queue[rear++] = next;
                    }
                }
            }
        }
        front += size;
        if (*returnSize > 0) break;
    }

    return result;
}