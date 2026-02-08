import java.util.Arrays;

class Solution {
    public boolean[] canRearrangeQueries(String s, int[][] queries) {
        int n = s.length();
        int m = queries.length;
        boolean[] result = new boolean[m];
        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }
        int[] prefixSumOdd = new int[n + 1];
        int oddCount = 0;
        for (int i = 0; i < 26; i++) {
            if (count[i] % 2 != 0) {
                oddCount++;
            }
        }

        for (int i = 0; i < m; i++) {
            int l = queries[i][0];
            int r = queries[i][1];
            int k = queries[i][2];

            int len = r - l + 1;
            if (len % 2 == 0) {
                if (oddCount <= 2 * k) {
                    result[i] = true;
                }
            } else {
                if (oddCount - 1 <= 2 * k) {
                    result[i] = true;
                }
            }

        }
        return result;
    }
}