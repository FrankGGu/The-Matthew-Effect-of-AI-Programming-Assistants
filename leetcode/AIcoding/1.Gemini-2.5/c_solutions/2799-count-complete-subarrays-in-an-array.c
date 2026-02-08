#include <stdbool.h>

int countCompleteSubarrays(int* nums, int numsSize) {
    bool global_seen[2001] = {false};
    int k = 0;
    for (int i = 0; i < numsSize; i++) {
        if (!global_seen[nums[i]]) {
            global_seen[nums[i]] = true;
            k++;
        }
    }

    int complete_subarrays_count = 0;

    for (int i = 0; i < numsSize; i++) {
        bool current_subarray_seen[2001] = {false};
        int current_distinct_count = 0;

        for (int j = i; j < numsSize; j++) {
            if (!current_subarray_seen[nums[j]]) {
                current_subarray_seen[nums[j]] = true;
                current_distinct_count++;
            }

            if (current_distinct_count == k) {
                complete_subarrays_count++;
            }
        }
    }

    return complete_subarrays_count;
}