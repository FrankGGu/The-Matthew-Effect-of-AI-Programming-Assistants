#include <stdlib.h>

void dfs(int current, int n, int* result, int* index) {
    result[(*index)++] = current;

    for (int i = 0; i <= 9; i++) {
        int next = current * 10 + i;
        if (next > n) {
            break;
        }
        dfs(next, n, result, index);
    }
}

int* lexicalOrder(int n, int* returnSize) {
    *returnSize = n;
    int* result = (int*)malloc(n * sizeof(int));

    int currentIndex = 0;

    for (int i = 1; i <= 9; i++) {
        if (i <= n) {
            dfs(i, n, result, &currentIndex);
        } else {
            break;
        }
    }

    return result;
}