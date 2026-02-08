public class Solution {
    public int minFoodBuckets(String street, int[] hamsters) {
        int n = street.length();
        int[] dp = new int[n + 1];

        for (int i = 0; i < n; i++) {
            if (street.charAt(i) == 'H') {
                if (i - 1 >= 0 && street.charAt(i - 1) == 'F') {
                    dp[i + 1] = dp[i];
                } else {
                    dp[i + 1] = dp[i] + 1;
                }
            } else {
                dp[i + 1] = dp[i];
            }
        }

        return dp[n];
    }
}