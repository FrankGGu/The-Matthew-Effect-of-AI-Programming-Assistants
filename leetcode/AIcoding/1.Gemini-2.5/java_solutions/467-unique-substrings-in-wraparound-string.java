class Solution {
    public int findSubstringInWraproundString(String p) {
        if (p == null || p.length() == 0) {
            return 0;
        }

        int[] dp = new int[26]; 

        int currentMaxLen = 0;
        for (int i = 0; i < p.length(); i++) {
            if (i > 0) {
                char prev = p.charAt(i - 1);
                char curr = p.charAt(i);
                if (curr - prev == 1 || (prev == 'z' && curr == 'a')) {
                    currentMaxLen++;
                } else {
                    currentMaxLen = 1;
                }
            } else {
                currentMaxLen = 1;
            }

            int charIdx = p.charAt(i) - 'a';
            dp[charIdx] = Math.max(dp[charIdx], currentMaxLen);
        }

        int totalUniqueSubstrings = 0;
        for (int count : dp) {
            totalUniqueSubstrings += count;
        }

        return totalUniqueSubstrings;
    }
}