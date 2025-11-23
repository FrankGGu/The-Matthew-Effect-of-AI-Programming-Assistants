#include <stdio.h>
#include <stdlib.h>

void dfs(int n, int curr, int *result, int *returnSize) {
    if (curr > n) return;
    result[(*returnSize)++] = curr;
    for (int i = 0; i < 10; i++) {
        if (curr * 10 + i > n) break;
        dfs(n, curr * 10 + i, result, returnSize);
    }
}

int* lexicalOrder(int n, int* returnSize) {
    int *result = (int *)malloc(n * sizeof(int));
    *returnSize = 0;
    for (int i = 1; i <= 9 && i <= n; i++) {
        dfs(n, i, result, returnSize);
    }
    return result;
}