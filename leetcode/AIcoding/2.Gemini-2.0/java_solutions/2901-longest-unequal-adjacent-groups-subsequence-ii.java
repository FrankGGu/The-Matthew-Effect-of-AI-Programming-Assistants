import java.util.Arrays;

class Solution {
    public int longestUnequalAdjacentGroupsSubsequence(String[] words, int[] groups) {
        int n = words.length;
        int[] dp = new int[n];
        Arrays.fill(dp, 1);
        int ans = 1;

        for (int i = 1; i < n; i++) {
            for (int j = 0; j < i; j++) {
                if (groups[i] != groups[j] && isDifferent(words[i], words[j])) {
                    dp[i] = Math.max(dp[i], dp[j] + 1);
                }
            }
            ans = Math.max(ans, dp[i]);
        }

        return ans;
    }

    private boolean isDifferent(String s1, String s2) {
        int diff = 0;
        int minLen = Math.min(s1.length(), s2.length());
        int maxLen = Math.max(s1.length(), s2.length());
        if (Math.abs(s1.length() - s2.length()) > 1) return false;

        if (s1.length() == s2.length()) {
            for (int i = 0; i < s1.length(); i++) {
                if (s1.charAt(i) != s2.charAt(i)) {
                    diff++;
                }
            }
            return diff == 1;
        } else {
            String longer = (s1.length() > s2.length()) ? s1 : s2;
            String shorter = (s1.length() > s2.length()) ? s2 : s1;
            int i = 0, j = 0;
            while (i < longer.length() && j < shorter.length()) {
                if (longer.charAt(i) == shorter.charAt(j)) {
                    i++;
                    j++;
                } else {
                    i++;
                    diff++;
                }
            }
            diff += longer.length() - i;
            return diff <= 1;
        }
    }
}