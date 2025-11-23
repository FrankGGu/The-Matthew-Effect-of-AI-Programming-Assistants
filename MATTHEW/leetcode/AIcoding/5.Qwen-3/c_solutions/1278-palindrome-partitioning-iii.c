#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int min(int a, int b) {
    return a < b ? a : b;
}

int dp[101][101];

int countChanges(char *s, int left, int right) {
    int changes = 0;
    while (left < right) {
        if (s[left] != s[right]) {
            changes++;
        }
        left++;
        right--;
    }
    return changes;
}

void helper(char *s, int start, int k, int **result, int *current, int *currentSize, int n) {
    if (k == 0) {
        if (start == n) {
            int *newResult = (int *)malloc(*currentSize * sizeof(int));
            memcpy(newResult, current, *currentSize * sizeof(int));
            *result = newResult;
            return;
        }
        return;
    }

    for (int i = start; i < n; i++) {
        int cost = dp[start][i];
        current[*currentSize] = cost;
        (*currentSize)++;
        helper(s, i + 1, k - 1, result, current, currentSize, n);
        (*currentSize)--;
    }
}

int **partition(char *s, int k, int **returnSize, int **returnColumnSizes) {
    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        for (int j = i; j < n; j++) {
            dp[i][j] = countChanges(s, i, j);
        }
    }

    int **result = NULL;
    int currentSize = 0;
    int *current = (int *)malloc(n * sizeof(int));

    helper(s, 0, k, &result, current, &currentSize, n);

    *returnSize = (int *)malloc(sizeof(int));
    *returnColumnSizes = (int *)malloc(sizeof(int));
    (*returnSize)[0] = 1;
    (*returnColumnSizes)[0] = k;

    free(current);
    return result;
}