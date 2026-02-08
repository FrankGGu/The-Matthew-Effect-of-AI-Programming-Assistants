class Solution {
    public long countNonDecreasing(int[] nums, int k) {
        int n = nums.length;
        long count = 0;
        long[] dp = new long[n];
        int left = 0;

        for (int right = 0; right < n; right++) {
            while (right > 0 && nums[right] < nums[right - 1]) {
                left = right;
            }
            dp[right] = right - left + 1;

            if (right > 0) {
                dp[right] += dp[right - 1] - (right - k >= left ? dp[right - k] : 0);
            }

            count += dp[right];
        }

        return count;
    }
}