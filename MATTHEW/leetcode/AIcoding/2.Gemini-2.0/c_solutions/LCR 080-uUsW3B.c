#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** combine(int n, int k, int* returnSize, int** returnColumnSizes) {
    *returnSize = 0;
    if (k <= 0 || k > n) return NULL;

    int** result = (int**)malloc(sizeof(int*) * 100000);
    *returnColumnSizes = (int*)malloc(sizeof(int) * 100000);
    int* combination = (int*)malloc(sizeof(int) * k);

    void backtrack(int start, int index) {
        if (index == k) {
            result[*returnSize] = (int*)malloc(sizeof(int) * k);
            (*returnColumnSizes)[*returnSize] = k;
            for (int i = 0; i < k; i++) {
                result[*returnSize][i] = combination[i];
            }
            (*returnSize)++;
            return;
        }

        for (int i = start; i <= n; i++) {
            combination[index] = i;
            backtrack(i + 1, index + 1);
        }
    }

    backtrack(1, 0);

    free(combination);
    return result;
}