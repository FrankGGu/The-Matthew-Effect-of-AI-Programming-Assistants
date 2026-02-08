class Solution {
    public String findTheString(int[][] lcp) {
        int n = lcp.length;
        char[] res = new char[n];
        char cur = 'a';
        for (int i = 0; i < n; i++) {
            if (res[i] == '\0') {
                res[i] = cur++;
            }
            for (int j = i + 1; j < n; j++) {
                if (lcp[i][j] > 0 && res[j] == '\0') {
                    res[j] = res[i];
                }
            }
        }

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                int len = 0;
                if (res[i] == res[j]) {
                    int k = 0;
                    while (i + k < n && j + k < n && res[i + k] == res[j + k]) {
                        k++;
                    }
                    len = k;
                }
                if (len != lcp[i][j]) {
                    return "";
                }
            }
        }

        return new String(res);
    }
}