import java.util.Arrays;

class Solution {
    public int findMaxK(int[] nums) {
        Arrays.sort(nums);
        int left = 0;
        int right = nums.length - 1;

        while (left < right) {
            int sum = nums[left] + nums[right];
            if (sum == 0) {
                // If nums[right] is positive, we found a pair.
                // Since the array is sorted and we are moving from the largest possible positive,
                // this nums[right] is the largest such k.
                if (nums[right] > 0) {
                    return nums[right];
                } else {
                    // This case implies nums[right] is 0 or negative.
                    // If nums[right] is 0, then nums[left] must also be 0. We need a positive k.
                    // If nums[right] is negative, it contradicts the sorted order for left < right.
                    // In a valid scenario for sum == 0, nums[left] must be negative and nums[right] must be positive.
                    // We move both pointers to continue searching for other pairs, though this branch should ideally not be hit for a valid positive k.
                    left++;
                    right--;
                }
            } else if (sum < 0) {
                // The sum is negative, meaning nums[left] is too small (too negative).
                // To get closer to zero, we need a larger (less negative) number from the left.
                left++;
            } else { // sum > 0
                // The sum is positive, meaning nums[right] is too large (too positive).
                // To get closer to zero, we need a smaller number from the right.
                right--;
            }
        }

        return -1; // No such positive integer k found
    }
}