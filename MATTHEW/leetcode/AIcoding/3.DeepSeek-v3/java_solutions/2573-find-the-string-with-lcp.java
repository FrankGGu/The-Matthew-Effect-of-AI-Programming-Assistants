class Solution {
    public String findTheString(int[][] lcp) {
        int n = lcp.length;
        char[] res = new char[n];
        res[0] = 'a';
        for (int i = 1; i < n; i++) {
            res[i] = res[0];
            for (int j = 0; j < i; j++) {
                if (lcp[i][j] > 0) {
                    if (j + lcp[i][j] > n) return "";
                    if (i + lcp[i][j] > n) return "";
                    if (j > 0 && lcp[i][j] > lcp[i - 1][j - 1] + 1) return "";
                    res[i] = res[j];
                    break;
                }
            }
        }

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (i == j) {
                    if (lcp[i][j] != n - i) return "";
                } else {
                    int val = 0;
                    if (res[i] == res[j]) {
                        val = (i + 1 < n && j + 1 < n) ? lcp[i + 1][j + 1] + 1 : 1;
                        val = Math.min(val, n - Math.max(i, j));
                    }
                    if (lcp[i][j] != val) return "";
                }
            }
        }

        return new String(res);
    }
}