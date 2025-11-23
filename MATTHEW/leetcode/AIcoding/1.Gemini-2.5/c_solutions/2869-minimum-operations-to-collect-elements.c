#include <stdbool.h>
#include <string.h>

int minOperations(int* nums, int numsSize, int k) {
    bool collected[k + 1];
    memset(collected, false, sizeof(bool) * (k + 1));

    int count_collected_distinct = 0;
    int operations = 0;

    for (int i = numsSize - 1; i >= 0; --i) {
        operations++;
        int current_num = nums[i];

        if (current_num >= 1 && current_num <= k) {
            if (!collected[current_num]) {
                collected[current_num] = true;
                count_collected_distinct++;
            }
        }

        if (count_collected_distinct == k) {
            return operations;
        }
    }

    return operations;
}