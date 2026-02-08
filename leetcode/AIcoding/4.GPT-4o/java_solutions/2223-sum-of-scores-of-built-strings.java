class Solution {
    public long sumOfScores(String s) {
        int n = s.length();
        long totalScore = 0;
        int[] lps = new int[n];

        for (int i = 1, len = 0; i < n; ) {
            if (s.charAt(i) == s.charAt(len)) {
                lps[i++] = ++len;
            } else {
                if (len != 0) {
                    len = lps[len - 1];
                } else {
                    lps[i++] = 0;
                }
            }
        }

        for (int i = 0; i < n; i++) {
            totalScore += lps[i];
        }
        return totalScore + n;
    }
}