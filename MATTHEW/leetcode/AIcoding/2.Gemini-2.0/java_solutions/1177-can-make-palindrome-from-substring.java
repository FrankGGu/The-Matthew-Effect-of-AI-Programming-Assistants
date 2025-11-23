import java.util.Arrays;
import java.util.List;

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
        Boolean[] ans = new Boolean[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int left = queries[i][0];
            int right = queries[i][1];
            int k = queries[i][2];
            int oddCount = 0;
            for (int j = 0; j < 26; j++) {
                if ((prefix[right + 1][j] - prefix[left][j]) % 2 != 0) {
                    oddCount++;
                }
            }
            ans[i] = oddCount / 2 <= k;
        }
        return Arrays.asList(ans);
    }
}