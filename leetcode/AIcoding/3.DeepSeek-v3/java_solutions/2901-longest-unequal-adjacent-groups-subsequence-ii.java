class Solution {
    public List<String> getWordsInLongestSubsequence(int n, String[] words, int[] groups) {
        List<String> result = new ArrayList<>();
        int[] dp = new int[n];
        int[] prev = new int[n];
        Arrays.fill(prev, -1);
        int maxLen = 0;
        int lastIndex = -1;

        for (int i = 0; i < n; i++) {
            dp[i] = 1;
            for (int j = 0; j < i; j++) {
                if (groups[i] != groups[j] && isValid(words[i], words[j]) && dp[j] + 1 > dp[i]) {
                    dp[i] = dp[j] + 1;
                    prev[i] = j;
                }
            }
            if (dp[i] > maxLen) {
                maxLen = dp[i];
                lastIndex = i;
            }
        }

        while (lastIndex != -1) {
            result.add(0, words[lastIndex]);
            lastIndex = prev[lastIndex];
        }

        return result;
    }

    private boolean isValid(String a, String b) {
        if (a.length() != b.length()) {
            return false;
        }
        int diff = 0;
        for (int i = 0; i < a.length(); i++) {
            if (a.charAt(i) != b.charAt(i)) {
                diff++;
                if (diff > 1) {
                    return false;
                }
            }
        }
        return diff == 1;
    }
}