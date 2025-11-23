#include <stdlib.h>
#include <string.h>

long long maxSum(int* nums, int numsSize, int m, int k) {
    long long max_sum = 0;
    long long current_sum = 0;
    int* freq = (int*)calloc(100001, sizeof(int));
    int unique_count = 0;

    for (int i = 0; i < k; i++) {
        current_sum += nums[i];
        if (freq[nums[i]] == 0) {
            unique_count++;
        }
        freq[nums[i]]++;
    }

    if (unique_count >= m) {
        max_sum = current_sum;
    }

    for (int i = k; i < numsSize; i++) {
        current_sum += nums[i] - nums[i - k];

        freq[nums[i - k]]--;
        if (freq[nums[i - k]] == 0) {
            unique_count--;
        }

        if (freq[nums[i]] == 0) {
            unique_count++;
        }
        freq[nums[i]]++;

        if (unique_count >= m && current_sum > max_sum) {
            max_sum = current_sum;
        }
    }

    free(freq);
    return max_sum;
}