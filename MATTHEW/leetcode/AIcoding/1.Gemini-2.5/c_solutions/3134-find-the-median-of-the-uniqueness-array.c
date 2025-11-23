#include <stdlib.h>
#include <string.h>

#define MAX_NUM_VAL 100001

static int freq[MAX_NUM_VAL];

long long count_le(int* nums, int numsSize, int x) {
    memset(freq, 0, sizeof(freq));

    long long count = 0;
    int left = 0;
    int unique_elements = 0;

    for (int right = 0; right < numsSize; ++right) {
        if (freq[nums[right]] == 0) {
            unique_elements++;
        }
        freq[nums[right]]++;

        while (unique_elements > x) {
            freq[nums[left]]--;
            if (freq[nums[left]] == 0) {
                unique_elements--;
            }
            left++;
        }
        count += (right - left + 1);
    }
    return count;
}

int findMedian(int* nums, int numsSize) {
    long long total_subarrays = (long long)numsSize * (numsSize + 1) / 2;
    long long target_count = (total_subarrays + 1) / 2;

    int low = 1;
    int high = numsSize;
    int ans = numsSize;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (count_le(nums, numsSize, mid) >= target_count) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return ans;
}