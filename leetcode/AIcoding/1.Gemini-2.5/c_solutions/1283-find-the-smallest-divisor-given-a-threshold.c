#include <limits.h> // Required for INT_MAX if used, but not strictly needed here.

long long calculateSum(int* nums, int numsSize, int divisor) {
    long long currentSum = 0;
    for (int i = 0; i < numsSize; i++) {
        // This is equivalent to ceil((double)nums[i] / divisor) using integer division.
        // For positive integers a, b: ceil(a/b) = (a + b - 1) / b
        currentSum += (nums[i] + divisor - 1) / divisor;
    }
    return currentSum;
}

int smallestDivisor(int* nums, int numsSize, int threshold) {
    int left = 1; // The smallest possible divisor is 1.

    // The largest possible divisor can be the maximum value in nums.
    // If the divisor is larger than max(nums), then each nums[i]/divisor will be 0.something,
    // resulting in ceil(nums[i]/divisor) being 1 for all nums[i] > 0.
    // A divisor equal to max(nums) already achieves this for its own value.
    // So, we can set the upper bound for binary search to the maximum element in nums.
    int right = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > right) {
            right = nums[i];
        }
    }

    int ans = right; // Initialize ans with a value that is guaranteed to satisfy the condition (e.g., max element)

    // Perform binary search
    while (left <= right) {
        int mid = left + (right - left) / 2;

        if (calculateSum(nums, numsSize, mid) <= threshold) {
            // If the sum is less than or equal to threshold,
            // 'mid' is a possible answer. We try to find a smaller divisor.
            ans = mid;
            right = mid - 1;
        } else {
            // If the sum is greater than threshold,
            // 'mid' is too small; we need a larger divisor to reduce the sum.
            left = mid + 1;
        }
    }

    return ans;
}