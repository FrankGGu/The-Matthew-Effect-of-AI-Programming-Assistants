public class Solution {

import java.util.Arrays;

public class Solution {
    public int minOperations(int[] nums, int k) {
        Arrays.sort(nums);
        int n = nums.length;
        int medianIndex = n / 2;
        int median = nums[medianIndex];
        int operations = 0;

        if (median < k) {
            for (int i = medianIndex; i < n; i++) {
                if (nums[i] < k) {
                    operations += k - nums[i];
                } else {
                    break;
                }
            }
        } else {
            for (int i = medianIndex; i >= 0; i--) {
                if (nums[i] > k) {
                    operations += nums[i] - k;
                } else {
                    break;
                }
            }
        }

        return operations;
    }
}
}