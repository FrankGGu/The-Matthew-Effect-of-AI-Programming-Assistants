#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void swap(char *a, char *b) {
    char temp = *a;
    *a = *b;
    *b = temp;
}

void backtrack(char *s, int start, int end, char ***result, int *returnSize) {
    if (start == end) {
        (*result)[(*returnSize)++] = strdup(s);
        return;
    }
    for (int i = start; i <= end; i++) {
        swap(&s[start], &s[i]);
        backtrack(s, start + 1, end, result, returnSize);
        swap(&s[start], &s[i]);
    }
}

char **permute(char *s, int *returnSize) {
    int len = strlen(s);
    *returnSize = 0;
    char **result = (char **)malloc(sizeof(char *) * factorial(len));
    backtrack(s, 0, len - 1, &result, returnSize);
    return result;
}

int factorial(int n) {
    return n <= 1 ? 1 : n * factorial(n - 1);
}

char **permutation(char *s, int *returnSize) {
    return permute(s, returnSize);
}