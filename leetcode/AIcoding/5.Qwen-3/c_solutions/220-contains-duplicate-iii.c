#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int val;
    int index;
} Pair;

int compare(const void *a, const void *b) {
    Pair *p1 = (Pair *)a;
    Pair *p2 = (Pair *)b;
    if (p1->val != p2->val) {
        return p1->val - p2->val;
    }
    return p1->index - p2->index;
}

bool containsNearbyAlmostDuplicate(int* nums, int numsSize, int k, int t) {
    if (numsSize < 2 || k < 0 || t < 0) return false;

    Pair *pairs = (Pair *)malloc(numsSize * sizeof(Pair));
    for (int i = 0; i < numsSize; i++) {
        pairs[i].val = nums[i];
        pairs[i].index = i;
    }

    qsort(pairs, numsSize, sizeof(Pair), compare);

    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize && (long long)abs((long long)pairs[j].val - (long long)pairs[i].val) <= (long long)t; j++) {
            if (abs(pairs[i].index - pairs[j].index) <= k) {
                free(pairs);
                return true;
            }
        }
    }

    free(pairs);
    return false;
}