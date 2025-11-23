import java.util.Arrays;

class Solution {
    public int minDifference(int[] nums) {
        int n = nums.length;

        if (n <= 4) {
            return 0;
        }

        Arrays.sort(nums);

        // We need to remove 3 elements. There are 4 scenarios for which 3 elements to remove:
        // 1. Remove 3 smallest elements: Remaining elements are from index 3 to n-1.
        //    Difference: nums[n-1] - nums[3]
        // 2. Remove 2 smallest and 1 largest: Remaining elements are from index 2 to n-2.
        //    Difference: nums[n-2] - nums[2]
        // 3. Remove 1 smallest and 2 largest: Remaining elements are from index 1 to n-3.
        //    Difference: nums[n-3] - nums[1]
        // 4. Remove 3 largest elements: Remaining elements are from index 0 to n-4.
        //    Difference: nums[n-4] - nums[0]

        int diff1 = nums[n - 1] - nums[3];
        int diff2 = nums[n - 2] - nums[2];
        int diff3 = nums[n - 3] - nums[1];
        int diff4 = nums[n - 4] - nums[0];

        return Math.min(Math.min(diff1, diff2), Math.min(diff3, diff4));
    }
}