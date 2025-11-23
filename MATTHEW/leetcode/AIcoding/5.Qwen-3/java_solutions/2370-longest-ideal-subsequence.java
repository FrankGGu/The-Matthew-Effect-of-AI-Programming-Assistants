public class Solution {
    public int longestIdealString(String s, int k) {
        int[] dp = new int[26];
        for (char c : s.toCharArray()) {
            int idx = c - 'a';
            int max = 0;
            for (int i = Math.max(0, idx - k); i <= Math.min(25, idx + k); i++) {
                max = Math.max(max, dp[i]);
            }
            dp[idx] = max + 1;
        }
        int result = 0;
        for (int val : dp) {
            result = Math.max(result, val);
        }
        return result;
    }
}