class Solution {
    private int[] parent;

    private void initDSU(int n) {
        parent = new int[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
        }
    }

    private int find(int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent[i]);
    }

    private void union(int i, int j) {
        int rootI = find(i);
        int rootJ = find(j);
        if (rootI != rootJ) {
            parent[rootI] = rootJ;
        }
    }

    public String findTheString(int[][] lcp) {
        int n = lcp.length;
        initDSU(n);

        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                if (lcp[i][j] < 0 || lcp[i][j] > n - Math.max(i, j)) {
                    return "";
                }
                if (lcp[i][j] != lcp[j][i]) {
                    return "";
                }
                if (i == j) {
                    if (lcp[i][j] != n - i) {
                        return "";
                    }
                } else {
                    for (int k = 0; k < lcp[i][j]; k++) {
                        union(i + k, j + k);
                    }
                }
            }
        }

        char[] sChars = new char[n];
        char nextChar = 'a';
        for (int i = 0; i < n; i++) {
            if (sChars[i] == 0) {
                if (nextChar > 'z') {
                    return "";
                }
                int root = find(i);
                for (int k = 0; k < n; k++) {
                    if (find(k) == root) {
                        sChars[k] = nextChar;
                    }
                }
                nextChar++;
            }
        }
        String s = new String(sChars);

        int[][] actualLCP = new int[n][n];
        for (int i = n - 1; i >= 0; i--) {
            for (int j = n - 1; j >= 0; j--) {
                if (s.charAt(i) == s.charAt(j)) {
                    if (i == n - 1 || j == n - 1) {
                        actualLCP[i][j] = 1;
                    } else {
                        actualLCP[i][j] = 1 + actualLCP[i + 1][j + 1];
                    }
                } else {
                    actualLCP[i][j] = 0;
                }
                if (actualLCP[i][j] != lcp[i][j]) {
                    return "";
                }
            }
        }

        return s;
    }
}