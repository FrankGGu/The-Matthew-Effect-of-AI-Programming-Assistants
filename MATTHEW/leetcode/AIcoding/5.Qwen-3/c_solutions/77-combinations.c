#include <stdio.h>
#include <stdlib.h>

int** combine(int n, int k, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(sizeof(int*) * 10000);
    *returnColumnSizes = (int*)malloc(sizeof(int) * 10000);
    *returnSize = 0;

    int* current = (int*)malloc(sizeof(int) * k);

    void backtrack(int start, int depth) {
        if (depth == k) {
            result[*returnSize] = (int*)malloc(sizeof(int) * k);
            for (int i = 0; i < k; i++) {
                result[*returnSize][i] = current[i];
            }
            (*returnColumnSizes)[*returnSize] = k;
            (*returnSize)++;
            return;
        }

        for (int i = start; i <= n; i++) {
            current[depth] = i;
            backtrack(i + 1, depth + 1);
        }
    }

    backtrack(1, 0);
    free(current);
    return result;
}