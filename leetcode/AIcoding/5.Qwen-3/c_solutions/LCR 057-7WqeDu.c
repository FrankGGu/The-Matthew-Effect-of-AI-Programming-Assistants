#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    int val;
    int index;
} Pair;

int compare(const void *a, const void *b) {
    Pair *p1 = (Pair *)a;
    Pair *p2 = (Pair *)b;
    return p1->val - p2->val;
}

bool containsNearbyAlmostDuplicate(int* nums, int numsSize, int k, int t) {
    if (nums == NULL || numsSize <= 0 || k < 0 || t < 0) return false;

    Pair *pairs = (Pair *)malloc(numsSize * sizeof(Pair));
    for (int i = 0; i < numsSize; i++) {
        pairs[i].val = nums[i];
        pairs[i].index = i;
    }

    qsort(pairs, numsSize, sizeof(Pair), compare);

    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (labs((long long)pairs[i].val - pairs[j].val) > t) break;
            if (abs(pairs[i].index - pairs[j].index) <= k) {
                free(pairs);
                return true;
            }
        }
    }

    free(pairs);
    return false;
}