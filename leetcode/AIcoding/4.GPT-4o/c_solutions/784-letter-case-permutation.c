#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void backtrack(char *s, int index, char **result, int *returnSize) {
    if (index == strlen(s)) {
        result[(*returnSize)++] = strdup(s);
        return;
    }

    backtrack(s, index + 1, result, returnSize);

    if (s[index] >= 'a' && s[index] <= 'z') {
        s[index] -= 32;
        backtrack(s, index + 1, result, returnSize);
        s[index] += 32;
    } else if (s[index] >= 'A' && s[index] <= 'Z') {
        s[index] += 32;
        backtrack(s, index + 1, result, returnSize);
        s[index] -= 32;
    }
}

char **letterCasePermutation(char *s, int *returnSize) {
    int maxSize = 1 << strlen(s);
    char **result = (char **)malloc(maxSize * sizeof(char *));
    *returnSize = 0;
    backtrack(s, 0, result, returnSize);
    return result;
}