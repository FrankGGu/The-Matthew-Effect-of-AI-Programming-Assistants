class Solution {
    public long beautifulSubstrings(String s) {
        int n = s.length();
        long count = 0;
        long[] dp = new long[n + 1];
        dp[0] = 1;
        int[] freq = new int[2];

        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == '1') {
                freq[0]++;
            } else {
                freq[1]++;
            }
            int key = freq[0] - freq[1] + 1;
            count += dp[key];
            dp[key]++;
        }

        return count;
    }
}