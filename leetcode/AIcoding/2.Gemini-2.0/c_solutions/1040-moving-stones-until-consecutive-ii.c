#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* numMovesStonesII(int* stones, int stonesSize, int* returnSize){
    qsort(stones, stonesSize, sizeof(int), cmp);
    int maxMoves = 0;
    int minMoves = INT_MAX;
    int i = 0;
    int n = stonesSize;
    for (int j = 0; j < n; j++) {
        while (stones[j] - stones[i] + 1 > n) {
            i++;
        }
        int count = j - i + 1;
        if (count == n && stones[j] - stones[i] + 1 == n - 1) {
            minMoves = 2;
        } else {
            minMoves = fmin(minMoves, n - count);
        }
    }
    maxMoves = fmax(stones[n - 1] - stones[1] - n + 2, stones[n - 2] - stones[0] - n + 2);
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = minMoves;
    result[1] = maxMoves;
    *returnSize = 2;
    return result;
}