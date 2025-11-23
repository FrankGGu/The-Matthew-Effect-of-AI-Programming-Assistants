#include <stdlib.h>
#include <string.h>

typedef struct {
    int val;
    int idx;
} Pair;

int cmp(const void* a, const void* b) {
    return ((Pair*)a)->val - ((Pair*)b)->val;
}

long long countOperationsToEmptyArray(int* nums, int numsSize) {
    Pair* pairs = (Pair*)malloc(numsSize * sizeof(Pair));
    for (int i = 0; i < numsSize; i++) {
        pairs[i].val = nums[i];
        pairs[i].idx = i;
    }

    qsort(pairs, numsSize, sizeof(Pair), cmp);

    long long res = numsSize;
    for (int i = 1; i < numsSize; i++) {
        if (pairs[i].idx < pairs[i - 1].idx) {
            res += numsSize - i;
        }
    }

    free(pairs);
    return res;
}