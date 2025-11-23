#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_WORDS 1000
#define MAX_LENGTH 100

typedef struct {
    char **data;
    int size;
} StringList;

void backtrack(char *s, int start, StringList *dict, char **result, int *returnSize, char *path, int pathLen) {
    if (start == strlen(s)) {
        result[*returnSize] = (char *)malloc((pathLen + 1) * sizeof(char));
        strncpy(result[*returnSize], path, pathLen);
        result[*returnSize][pathLen] = '\0';
        (*returnSize)++;
        return;
    }

    for (int i = start; i < strlen(s); i++) {
        char temp[MAX_LENGTH] = {0};
        strncpy(temp, s + start, i - start + 1);
        temp[i - start + 1] = '\0';

        for (int j = 0; j < dict->size; j++) {
            if (strcmp(temp, dict->data[j]) == 0) {
                int newLen = pathLen + (pathLen ? 1 : 0) + (i - start + 1);
                if (newLen < MAX_LENGTH) {
                    char newPath[MAX_LENGTH] = {0};
                    snprintf(newPath, sizeof(newPath), "%s%s%s", path, pathLen ? " " : "", temp);
                    backtrack(s, i + 1, dict, result, returnSize, newPath, newLen);
                }
            }
        }
    }
}

char **wordBreak(char *s, char **wordDict, int wordDictSize, int *returnSize) {
    StringList dict;
    dict.data = wordDict;
    dict.size = wordDictSize;

    char **result = (char **)malloc(MAX_WORDS * sizeof(char *));
    *returnSize = 0;
    char path[MAX_LENGTH] = {0};

    backtrack(s, 0, &dict, result, returnSize, path, 0);

    return result;
}