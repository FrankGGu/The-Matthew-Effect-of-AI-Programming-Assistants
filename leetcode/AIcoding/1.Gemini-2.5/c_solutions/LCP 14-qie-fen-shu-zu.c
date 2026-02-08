#include <stdbool.h>
#include <math.h> // For fmax

bool canSplit(long long maxSum, int* nums, int numsSize, int k) {
    long long currentSum = 0;
    int splits = 1; // Start with 1 split, as the first subarray is always there

    for (int i = 0; i < numsSize; ++i) {
        if (currentSum + nums[i] <= maxSum) {
            currentSum += nums[i];
        } else {
            splits++;
            currentSum = nums[i]; // Start a new subarray with the current element

            // If the current element itself is greater than maxSum, it's impossible.
            // This is implicitly handled by the binary search's 'left' boundary
            // but explicitly checking it here adds robustness.
            if (nums[i] > maxSum) {
                return false;
            }

            // If we exceed k splits, it's not possible with this maxSum
            if (splits > k) {
                return false;
            }
        }
    }
    return true; // If we finish the loop, it means splits <= k
}

int splitArray(int* nums, int numsSize, int k) {
    long long left = 0; // Minimum possible largest sum (max element in nums)
    long long right = 0; // Maximum possible largest sum (sum of all elements in nums)

    for (int i = 0; i < numsSize; ++i) {
        left = fmax(left, nums[i]); // Calculate max element
        right += nums[i];           // Calculate total sum
    }

    long long ans = right; // Initialize answer with the maximum possible sum

    // Binary search for the minimum largest sum
    while (left <= right) {
        long long mid = left + (right - left) / 2; // Calculate mid point

        if (canSplit(mid, nums, numsSize, k)) {
            // If it's possible to split with 'mid' as max sum,
            // try for a smaller max sum.
            ans = mid;
            right = mid - 1;
        } else {
            // If it's not possible, 'mid' is too small,
            // we need a larger max sum.
            left = mid + 1;
        }
    }

    return (int)ans;
}