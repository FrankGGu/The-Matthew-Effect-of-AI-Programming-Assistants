import java.util.Arrays;

class Solution {
    public long[] maxSumAndMinSum(int[] nums, int k) {
        int n = nums.length;
        long max_sum = Long.MIN_VALUE;
        long min_sum = Long.MAX_VALUE;

        for (int i = 0; i < n; i++) {
            long current_max_sum = 0;
            long current_min_sum = 0;
            for (int j = i; j < Math.min(i + k, n); j++) {
                current_max_sum += nums[j];
                current_min_sum += nums[j];

                max_sum = Math.max(max_sum, current_max_sum);
                min_sum = Math.min(min_sum, current_min_sum);
            }

            for (int j = i + k; j < n; j++) {
                current_max_sum += nums[j];
                current_max_sum -= nums[j - k];

                current_min_sum += nums[j];
                current_min_sum -= nums[j - k];

                max_sum = Math.max(max_sum, current_max_sum);
                min_sum = Math.min(min_sum, current_min_sum);
            }
        }

        return new long[] {max_sum, min_sum};
    }
}