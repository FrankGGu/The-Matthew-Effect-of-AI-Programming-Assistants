#include <stdbool.h>
#include <string.h>

int maximumUniqueSubarray(int* nums, int numsSize) {
    bool seen[1001]; // Max value of nums[i] is 1000
    memset(seen, false, sizeof(seen));

    int left = 0;
    int current_sum = 0;
    int max_sum = 0;

    for (int right = 0; right < numsSize; ++right) {
        int num_right = nums[right];

        while (seen[num_right]) {
            current_sum -= nums[left];
            seen[nums[left]] = false;
            left++;
        }

        current_sum += num_right;
        seen[num_right] = true;

        if (current_sum > max_sum) {
            max_sum = current_sum;
        }
    }

    return max_sum;
}