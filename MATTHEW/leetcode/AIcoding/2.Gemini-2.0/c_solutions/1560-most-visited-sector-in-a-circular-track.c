#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* mostVisited(int n, int* rounds, int roundsSize, int* returnSize) {
    int start = rounds[0];
    int end = rounds[roundsSize - 1];

    if (start <= end) {
        *returnSize = end - start + 1;
        int* result = (int*)malloc(sizeof(int) * (*returnSize));
        for (int i = 0; i < *returnSize; i++) {
            result[i] = start + i;
        }
        return result;
    } else {
        *returnSize = n - start + end + 1;
        int* result = (int*)malloc(sizeof(int) * (*returnSize));
        int index = 0;
        for (int i = start; i <= n; i++) {
            result[index++] = i;
        }
        for (int i = 1; i <= end; i++) {
            result[index++] = i;
        }
        return result;
    }
}