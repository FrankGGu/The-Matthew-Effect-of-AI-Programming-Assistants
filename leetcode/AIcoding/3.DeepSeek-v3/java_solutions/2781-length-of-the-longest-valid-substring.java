class Solution {
    public int longestValidSubstring(String word, List<String> forbidden) {
        Set<String> forbiddenSet = new HashSet<>(forbidden);
        int maxLen = 0;
        int left = 0;
        int n = word.length();

        for (int right = 0; right < n; right++) {
            for (int i = right; i >= left && i >= right - 10; i--) {
                String substring = word.substring(i, right + 1);
                if (forbiddenSet.contains(substring)) {
                    left = i + 1;
                    break;
                }
            }
            maxLen = Math.max(maxLen, right - left + 1);
        }

        return maxLen;
    }
}