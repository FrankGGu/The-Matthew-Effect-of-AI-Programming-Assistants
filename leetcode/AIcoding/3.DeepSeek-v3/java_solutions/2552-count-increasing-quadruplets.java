class Solution {
    public long countQuadruplets(int[] nums) {
        int n = nums.length;
        long res = 0;
        int[] dp = new int[n];

        for (int l = 0; l < n; l++) {
            int cnt = 0;
            for (int j = 0; j < l; j++) {
                if (nums[j] < nums[l]) {
                    res += dp[j];
                    cnt++;
                } else if (nums[j] > nums[l]) {
                    dp[j] += cnt;
                }
            }
        }

        return res;
    }
}