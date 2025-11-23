class Solution {
    public boolean[] canMakePalindromeQueries(String s, int[][] queries) {
        int n = s.length();
        int[][] prefixCounts = new int[n + 1][26];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < 26; j++) {
                prefixCounts[i + 1][j] = prefixCounts[i][j];
            }
            char currentChar = s.charAt(i);
            prefixCounts[i + 1][currentChar - 'a']++;
        }

        boolean[] results = new boolean[queries.length];
        for (int qIdx = 0; qIdx < queries.length; qIdx++) {
            int l = queries[qIdx][0];
            int r = queries[qIdx][1];
            int k = queries[qIdx][2];

            int oddFreqChars = 0;
            for (int j = 0; j < 26; j++) {
                int count = prefixCounts[r + 1][j] - prefixCounts[l][j];
                if (count % 2 != 0) {
                    oddFreqChars++;
                }
            }

            results[qIdx] = (oddFreqChars / 2 <= k);
        }

        return results;
    }
}