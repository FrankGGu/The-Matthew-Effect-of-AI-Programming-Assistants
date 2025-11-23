class Solution {
    public boolean canMakePaliQueries(String s, int[][] queries) {
        int n = s.length();
        int[][] count = new int[n + 1][26];

        for (int i = 0; i < n; i++) {
            count[i + 1] = count[i].clone();
            count[i + 1][s.charAt(i) - 'a']++;
        }

        boolean[] results = new boolean[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int left = queries[i][0], right = queries[i][1], k = queries[i][2];
            int oddCount = 0;
            for (int j = 0; j < 26; j++) {
                if ((count[right + 1][j] - count[left][j]) % 2 != 0) {
                    oddCount++;
                }
            }
            results[i] = oddCount / 2 <= k;
        }
        return results;
    }
}