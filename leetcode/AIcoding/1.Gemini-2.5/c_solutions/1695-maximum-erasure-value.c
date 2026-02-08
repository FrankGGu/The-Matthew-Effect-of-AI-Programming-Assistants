#include <stdlib.h> // For malloc, free (though not strictly needed for this solution style)
#include <string.h> // For memset

int maximumUniqueSubarray(int* nums, int numsSize) {
    int freq[10001]; // Constraints: 1 <= nums[i] <= 10^4
    memset(freq, 0, sizeof(freq));

    int left = 0;
    int current_sum = 0;
    int max_sum = 0;

    for (int right = 0; right < numsSize; right++) {
        current_sum += nums[right];
        freq[nums[right]]++;

        while (freq[nums[right]] > 1) {
            current_sum -= nums[left];
            freq[nums[left]]--;
            left++;
        }

        if (current_sum > max_sum) {
            max_sum = current_sum;
        }
    }

    return max_sum;
}