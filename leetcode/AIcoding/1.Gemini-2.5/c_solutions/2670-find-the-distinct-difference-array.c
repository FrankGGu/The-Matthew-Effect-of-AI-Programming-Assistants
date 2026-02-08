#include <stdlib.h>
#include <stdbool.h>

int* distinctDifferenceArray(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    int* ans = (int*)malloc(numsSize * sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        bool prefix_seen[51] = {false};
        int prefix_distinct_count = 0;
        for (int j = 0; j <= i; j++) {
            if (!prefix_seen[nums[j]]) {
                prefix_seen[nums[j]] = true;
                prefix_distinct_count++;
            }
        }

        bool suffix_seen[51] = {false};
        int suffix_distinct_count = 0;
        for (int k = i + 1; k < numsSize; k++) {
            if (!suffix_seen[nums[k]]) {
                suffix_seen[nums[k]] = true;
                suffix_distinct_count++;
            }
        }

        ans[i] = prefix_distinct_count - suffix_distinct_count;
    }

    return ans;
}