class Solution {
    public int maxSelectedElements(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        int[] dp = new int[n];
        Arrays.fill(dp, 1);
        int max = 1;

        for (int i = 1; i < n; i++) {
            if (nums[i] == nums[i - 1] + 1 || nums[i] == nums[i - 1]) {
                dp[i] = dp[i - 1] + 1;
                max = Math.max(max, dp[i]);
            }
        }

        return max;
    }
}