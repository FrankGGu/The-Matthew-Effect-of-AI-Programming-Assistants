import java.util.Arrays;

class Solution {
    public long minOperationsToMakeMedianK(int[] nums, int k) {
        Arrays.sort(nums);
        int n = nums.length;
        int medianIndex = n / 2;
        long operations = 0;

        // Step 1: Make the median element equal to k
        operations += Math.abs((long) nums[medianIndex] - k);

        // Step 2: Adjust elements to the left of the median
        // All elements to the left of medianIndex must be less than or equal to k
        for (int i = 0; i < medianIndex; i++) {
            if (nums[i] > k) {
                operations += (long) nums[i] - k;
            }
        }

        // Step 3: Adjust elements to the right of the median
        // All elements to the right of medianIndex must be greater than or equal to k
        for (int i = medianIndex + 1; i < n; i++) {
            if (nums[i] < k) {
                operations += k - (long) nums[i];
            }
        }

        return operations;
    }
}