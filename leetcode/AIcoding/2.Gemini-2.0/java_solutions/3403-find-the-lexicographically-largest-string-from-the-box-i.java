class Solution {
    public String findTheString(int[] lcp) {
        int n = lcp.length;
        char[] ans = new char[n];
        for (int i = 0; i < n; i++) {
            if (ans[i] == '\0') {
                ans[i] = 'a';
                for (int j = i + 1; j < n; j++) {
                    if (ans[j] == '\0' && lcp[i * n + j] > 0) {
                        ans[j] = 'a';
                    }
                }
            }
        }

        for (int i = 0; i < n; i++) {
            if (ans[i] == '\0') {
                for (char c = 'a'; c <= 'z'; c++) {
                    boolean used = false;
                    for(int j = 0; j < i; ++j) {
                        if(ans[j] == c) {
                            used = true;
                            break;
                        }
                    }
                    if(!used) {
                        ans[i] = c;
                        for (int j = i + 1; j < n; j++) {
                            if (ans[j] == '\0' && lcp[i * n + j] > 0) {
                                ans[j] = c;
                            }
                        }
                        break;
                    }
                }
                if(ans[i] == '\0') {
                    ans[i] = 'b';
                }

                for (int j = i + 1; j < n; j++) {
                    if (ans[j] == '\0' && lcp[i * n + j] > 0) {
                        ans[j] = ans[i];
                    }
                }

            }
        }

        for (int i = 0; i < n; i++) {
            if (ans[i] == '\0') return "";
        }

        int[][] newLcp = new int[n][n];
        for (int i = n - 1; i >= 0; i--) {
            for (int j = n - 1; j >= 0; j--) {
                if (ans[i] == ans[j]) {
                    if (i == n - 1 || j == n - 1) {
                        newLcp[i][j] = 1;
                    } else {
                        newLcp[i][j] = newLcp[i + 1][j + 1] + 1;
                    }
                } else {
                    newLcp[i][j] = 0;
                }
            }
        }

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (newLcp[i][j] != lcp[i * n + j]) {
                    return "";
                }
            }
        }

        return new String(ans);
    }
}