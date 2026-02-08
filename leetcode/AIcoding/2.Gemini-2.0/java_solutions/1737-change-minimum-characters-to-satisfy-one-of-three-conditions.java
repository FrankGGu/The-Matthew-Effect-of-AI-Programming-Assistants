class Solution {
    public int minCharacters(String a, String b) {
        int n = a.length();
        int m = b.length();
        int[] countA = new int[26];
        int[] countB = new int[26];
        int maxA = 0;
        int maxB = 0;
        for (char c : a.toCharArray()) {
            countA[c - 'a']++;
            maxA = Math.max(maxA, countA[c - 'a']);
        }
        for (char c : b.toCharArray()) {
            countB[c - 'a']++;
            maxB = Math.max(maxB, countB[c - 'a']);
        }
        int ans = n + m - Math.max(maxA, maxB);
        for (int i = 0; i < 25; i++) {
            int cur = 0;
            for (int j = 0; j < n; j++) {
                if (a.charAt(j) - 'a' >= i + 1) {
                    cur++;
                }
            }
            for (int j = 0; j < m; j++) {
                if (b.charAt(j) - 'a' < i + 1) {
                    cur++;
                }
            }
            ans = Math.min(ans, cur);
            cur = 0;
            for (int j = 0; j < n; j++) {
                if (a.charAt(j) - 'a' < i + 1) {
                    cur++;
                }
            }
            for (int j = 0; j < m; j++) {
                if (b.charAt(j) - 'a' >= i + 1) {
                    cur++;
                }
            }
            ans = Math.min(ans, cur);
        }
        return ans;
    }
}