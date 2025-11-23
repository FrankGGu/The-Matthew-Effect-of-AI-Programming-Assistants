class Solution {
    public int minOperations(int[] nums) {
        int n = nums.length;
        int[] dp = new int[n + 1];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        for (int i = 1; i <= n; i++) {
            for (int j = 0; j < i; j++) {
                if (nums[i - 1] > nums[j]) {
                    dp[i] = Math.min(dp[i], dp[j] + 1);
                }
            }
        }

        return n - Arrays.stream(dp).max().getAsInt();
    }
}