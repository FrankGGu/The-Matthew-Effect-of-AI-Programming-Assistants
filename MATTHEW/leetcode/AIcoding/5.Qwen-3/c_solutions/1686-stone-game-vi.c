#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    int *x = (int *)a;
    int *y = (int *)b;
    return (y[0] + y[1]) - (x[0] + x[1]);
}

int* stoneGameVI(int* alice, int aliceSize, int* bob, int bobSize, int* returnSize) {
    int **pairs = (int **)malloc(aliceSize * sizeof(int *));
    for (int i = 0; i < aliceSize; i++) {
        pairs[i] = (int *)malloc(2 * sizeof(int));
        pairs[i][0] = alice[i];
        pairs[i][1] = bob[i];
    }

    qsort(pairs, aliceSize, sizeof(int *), compare);

    int aliceTotal = 0, bobTotal = 0;

    for (int i = 0; i < aliceSize; i++) {
        aliceTotal += pairs[i][0];
        bobTotal += pairs[i][1];
    }

    *returnSize = 2;
    int *result = (int *)malloc(2 * sizeof(int));
    if (aliceTotal > bobTotal) {
        result[0] = 1;
        result[1] = 0;
    } else if (bobTotal > aliceTotal) {
        result[0] = 0;
        result[1] = 1;
    } else {
        result[0] = 1;
        result[1] = 1;
    }

    for (int i = 0; i < aliceSize; i++) {
        free(pairs[i]);
    }
    free(pairs);

    return result;
}