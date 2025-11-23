class Solution {
    public int longestVowelSubsequence(String s) {
        int[] dp = new int[5];
        for (char c : s.toCharArray()) {
            int index = -1;
            if (c == 'a') {
                index = 0;
            } else if (c == 'e') {
                index = 1;
            } else if (c == 'i') {
                index = 2;
            } else if (c == 'o') {
                index = 3;
            } else if (c == 'u') {
                index = 4;
            }
            if (index != -1) {
                if (index == 0) {
                    dp[0] = Math.max(dp[0], 1);
                } else {
                    dp[index] = Math.max(dp[index], dp[index - 1] + 1);
                }
            }
        }
        return dp[4];
    }
}