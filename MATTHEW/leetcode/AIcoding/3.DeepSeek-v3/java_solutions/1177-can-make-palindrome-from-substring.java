class Solution {
    public List<Boolean> canMakePaliQueries(String s, int[][] queries) {
        int n = s.length();
        int[][] prefix = new int[n + 1][26];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < 26; j++) {
                prefix[i + 1][j] = prefix[i][j];
            }
            prefix[i + 1][s.charAt(i) - 'a']++;
        }
        List<Boolean> res = new ArrayList<>();
        for (int[] query : queries) {
            int left = query[0];
            int right = query[1];
            int k = query[2];
            int odd = 0;
            for (int i = 0; i < 26; i++) {
                int cnt = prefix[right + 1][i] - prefix[left][i];
                if (cnt % 2 != 0) {
                    odd++;
                }
            }
            res.add(odd / 2 <= k);
        }
        return res;
    }
}