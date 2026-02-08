#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int val;
    int count;
} Pair;

int cmp(const void *a, const void *b) {
    return ((Pair *)b)->count - ((Pair *)a)->count;
}

int* topKFrequent(int* nums, int numsSize, int k, int* returnSize) {
    Pair* pairs = (Pair*)malloc(sizeof(Pair) * numsSize);
    int pairsSize = 0;

    for (int i = 0; i < numsSize; i++) {
        int found = 0;
        for (int j = 0; j < pairsSize; j++) {
            if (pairs[j].val == nums[i]) {
                pairs[j].count++;
                found = 1;
                break;
            }
        }
        if (!found) {
            pairs[pairsSize].val = nums[i];
            pairs[pairsSize].count = 1;
            pairsSize++;
        }
    }

    qsort(pairs, pairsSize, sizeof(Pair), cmp);

    int* result = (int*)malloc(sizeof(int) * k);
    for (int i = 0; i < k; i++) {
        result[i] = pairs[i].val;
    }

    *returnSize = k;
    free(pairs);
    return result;
}