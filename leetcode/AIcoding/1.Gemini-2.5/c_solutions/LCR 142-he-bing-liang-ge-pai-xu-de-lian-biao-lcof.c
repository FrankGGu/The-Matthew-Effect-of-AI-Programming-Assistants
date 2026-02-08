#include <limits.h>

int findMax(int* nums, int numsSize) {
    int max_val = INT_MIN;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max_val) {
            max_val = nums[i];
        }
    }
    return max_val;
}

long long countSubarrays(int* nums, int numsSize, int k) {
    int max_val = findMax(nums, numsSize);

    long long ans = 0;
    int left = 0;
    int count_max = 0;

    for (int right = 0; right < numsSize; right++) {
        if (nums[right] == max_val) {
            count_max++;
        }

        while (count_max >= k) {
            ans += (numsSize - right);

            if (nums[left] == max_val) {
                count_max--;
            }
            left++;
        }
    }

    return ans;
}