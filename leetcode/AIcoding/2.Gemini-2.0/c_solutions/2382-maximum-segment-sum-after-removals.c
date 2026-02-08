#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    long long val;
    int l, r;
} Segment;

int compare(const void *a, const void *b) {
    return ((Segment*)b)->val - ((Segment*)a)->val;
}

long long* maximumSegmentSum(int* nums, int numsSize, int* removeQueries, int removeQueriesSize, int* returnSize) {
    long long* ans = (long long*)malloc(sizeof(long long) * removeQueriesSize);
    *returnSize = removeQueriesSize;

    int* removed = (int*)calloc(numsSize, sizeof(int));
    long long max_sum = 0;

    for (int i = 0; i < removeQueriesSize; i++) {
        removed[removeQueries[i]] = 1;
        max_sum = 0;

        for (int j = 0; j < numsSize; j++) {
            if (removed[j]) continue;
            long long current_sum = 0;
            int k = j;
            while (k < numsSize && !removed[k]) {
                current_sum += nums[k];
                k++;
            }
            if (current_sum > max_sum) {
                max_sum = current_sum;
            }
            j = k - 1;
        }
        ans[i] = max_sum;
    }

    free(removed);
    return ans;
}