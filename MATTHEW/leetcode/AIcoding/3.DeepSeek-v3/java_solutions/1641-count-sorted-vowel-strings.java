class Solution {
    public int countVowelStrings(int n) {
        int[] dp = new int[5];
        Arrays.fill(dp, 1);
        for (int i = 2; i <= n; i++) {
            for (int j = 3; j >= 0; j--) {
                dp[j] += dp[j + 1];
            }
        }
        int sum = 0;
        for (int num : dp) {
            sum += num;
        }
        return sum;
    }
}