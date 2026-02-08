class Solution {
    public int minimumSubstringsInPartition(String s) {
        int n = s.length();
        int[] dp = new int[n + 1];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        for (int i = 1; i <= n; i++) {
            int[] freq = new int[26];
            for (int j = i; j >= 1; j--) {
                char c = s.charAt(j - 1);
                freq[c - 'a']++;
                if (isValid(freq)) {
                    if (dp[j - 1] != Integer.MAX_VALUE) {
                        dp[i] = Math.min(dp[i], dp[j - 1] + 1);
                    }
                }
            }
        }
        return dp[n];
    }

    private boolean isValid(int[] freq) {
        int count = -1;
        for (int num : freq) {
            if (num > 0) {
                if (count == -1) {
                    count = num;
                } else if (num != count) {
                    return false;
                }
            }
        }
        return true;
    }
}