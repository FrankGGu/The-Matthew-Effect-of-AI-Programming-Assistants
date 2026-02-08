#include <stdio.h>
#include <stdlib.h>

int** combinationSum3(int k, int n, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(sizeof(int*) * 1000);
    *returnColumnSizes = (int*)malloc(sizeof(int) * 1000);
    *returnSize = 0;

    int* path = (int*)malloc(sizeof(int) * k);
    int pathLen = 0;

    void backtrack(int start, int sum) {
        if (pathLen == k) {
            if (sum == n) {
                result[*returnSize] = (int*)malloc(sizeof(int) * k);
                for (int i = 0; i < k; i++) {
                    result[*returnSize][i] = path[i];
                }
                (*returnColumnSizes)[*returnSize] = k;
                (*returnSize)++;
            }
            return;
        }

        for (int i = start; i <= 9; i++) {
            path[pathLen++] = i;
            backtrack(i + 1, sum + i);
            pathLen--;
        }
    }

    backtrack(1, 0);

    return result;
}