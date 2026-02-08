#include <stdlib.h>

typedef struct {
    int aliceVal;
    int bobVal;
    int sumVal;
} Stone;

int compareStones(const void *a, const void *b) {
    Stone *stoneA = (Stone *)a;
    Stone *stoneB = (Stone *)b;
    return stoneB->sumVal - stoneA->sumVal;
}

int stoneGameVI(int* aliceValues, int aliceValuesSize, int* bobValues, int bobValuesSize) {
    int n = aliceValuesSize;
    Stone* stones = (Stone*)malloc(n * sizeof(Stone));

    for (int i = 0; i < n; i++) {
        stones[i].aliceVal = aliceValues[i];
        stones[i].bobVal = bobValues[i];
        stones[i].sumVal = aliceValues[i] + bobValues[i];
    }

    qsort(stones, n, sizeof(Stone), compareStones);

    long long aliceScore = 0;
    long long bobScore = 0;

    for (int i = 0; i < n; i++) {
        if (i % 2 == 0) {
            aliceScore += stones[i].aliceVal;
        } else {
            bobScore += stones[i].bobVal;
        }
    }

    free(stones);

    return (int)(aliceScore - bobScore);
}