#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int val;
    int count;
} Pair;

int compare(const void *a, const void *b) {
    return ((Pair *)b)->count - ((Pair *)a)->count;
}

int* topKFrequent(int* nums, int numsSize, int k, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * k);
    *returnSize = 0;

    if (numsSize == 0 || k <= 0) {
        return result;
    }

    Pair* pairs = (Pair*)malloc(sizeof(Pair) * numsSize);
    int pairCount = 0;

    for (int i = 0; i < numsSize; i++) {
        int found = 0;
        for (int j = 0; j < pairCount; j++) {
            if (pairs[j].val == nums[i]) {
                pairs[j].count++;
                found = 1;
                break;
            }
        }
        if (!found) {
            pairs[pairCount].val = nums[i];
            pairs[pairCount].count = 1;
            pairCount++;
        }
    }

    qsort(pairs, pairCount, sizeof(Pair), compare);

    for (int i = 0; i < k && i < pairCount; i++) {
        result[i] = pairs[i].val;
        (*returnSize)++;
    }

    free(pairs);
    return result;
}