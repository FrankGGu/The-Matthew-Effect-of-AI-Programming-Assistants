class Solution {
    public int scoreOfString(String s) {
        int score = 0;
        int balance = 0;
        for (char c : s.toCharArray()) {
            if (c == '(') {
                balance++;
            } else {
                balance--;
                if (balance < 0) return 0;
            }
        }
        if (balance != 0) return 0;

        int[] dp = new int[s.length() + 1];
        balance = 0;
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == '(') {
                balance++;
            } else {
                balance--;
                if (s.charAt(i - 1) == '(') {
                    dp[balance] = dp[balance + 1] + 1;
                }
            }
        }
        return dp[0];
    }
}