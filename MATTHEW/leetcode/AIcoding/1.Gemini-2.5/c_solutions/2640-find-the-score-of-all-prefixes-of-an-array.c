#include <stdlib.h>

long long* findPrefixScore(int* nums, int numsSize, int* returnSize) {
    long long* ans = (long long*)malloc(numsSize * sizeof(long long));
    *returnSize = numsSize;

    long long current_max_val = 0;
    long long previous_prefix_score_sum = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > current_max_val) {
            current_max_val = nums[i];
        }

        long long current_prefix_score_component = (long long)nums[i] + current_max_val;

        ans[i] = previous_prefix_score_sum + current_prefix_score_component;

        previous_prefix_score_sum = ans[i];
    }

    return ans;
}