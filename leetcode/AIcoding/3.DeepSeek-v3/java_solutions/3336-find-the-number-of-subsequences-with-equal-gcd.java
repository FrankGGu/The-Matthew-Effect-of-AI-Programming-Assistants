class Solution {
    public int countSubsequencesWithEqualGCD(int[] nums) {
        int maxNum = 0;
        for (int num : nums) {
            maxNum = Math.max(maxNum, num);
        }

        int[] count = new int[maxNum + 1];
        for (int num : nums) {
            count[num]++;
        }

        int[] dp = new int[maxNum + 1];
        for (int i = maxNum; i >= 1; i--) {
            int total = 0;
            for (int j = i; j <= maxNum; j += i) {
                total += count[j];
            }
            if (total == 0) {
                continue;
            }
            dp[i] = (1 << total) - 1;
            for (int j = 2 * i; j <= maxNum; j += i) {
                dp[i] -= dp[j];
            }
        }
        return dp[1];
    }
}