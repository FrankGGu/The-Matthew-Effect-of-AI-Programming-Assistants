class Solution {
    public int longestPath(String[] words) {
        int n = words.length;
        int[] maxLen = new int[n];
        int maxPath = 0;

        for (int i = 0; i < n; i++) {
            maxLen[i] = 1; // Each word can at least be a path of length 1
            for (int j = 0; j < i; j++) {
                if (isDifferent(words[i], words[j])) {
                    maxLen[i] = Math.max(maxLen[i], maxLen[j] + 1);
                }
            }
            maxPath = Math.max(maxPath, maxLen[i]);
        }

        return maxPath;
    }

    private boolean isDifferent(String a, String b) {
        int len = Math.min(a.length(), b.length());
        for (int i = 0; i < len; i++) {
            if (a.charAt(i) == b.charAt(i)) {
                return false;
            }
        }
        return true;
    }
}