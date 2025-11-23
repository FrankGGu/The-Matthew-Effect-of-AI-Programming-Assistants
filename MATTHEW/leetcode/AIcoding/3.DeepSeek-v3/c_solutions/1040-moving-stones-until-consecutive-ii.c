#include <stdlib.h>

int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int* numMovesStonesII(int* stones, int stonesSize, int* returnSize) {
    qsort(stones, stonesSize, sizeof(int), cmp);

    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 2;

    int n = stonesSize;
    int max_moves = stones[n - 1] - stones[0] + 1 - n;
    max_moves -= (stones[1] - stones[0] - 1) < (stones[n - 1] - stones[n - 2] - 1) ? 
                  (stones[1] - stones[0] - 1) : (stones[n - 1] - stones[n - 2] - 1);

    int min_moves = n;
    int j = 0;
    for (int i = 0; i < n; i++) {
        while (j + 1 < n && stones[j + 1] - stones[i] < n) {
            j++;
        }
        int cost = n - (j - i + 1);
        if (j - i + 1 == n - 1 && stones[j] - stones[i] + 1 == n - 1) {
            cost = 2;
        }
        if (cost < min_moves) {
            min_moves = cost;
        }
    }

    result[0] = min_moves;
    result[1] = max_moves;
    return result;
}