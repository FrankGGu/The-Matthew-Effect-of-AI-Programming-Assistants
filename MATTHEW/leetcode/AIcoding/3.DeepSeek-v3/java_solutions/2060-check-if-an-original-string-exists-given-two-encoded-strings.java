class Solution {
    public boolean possiblyEquals(String s1, String s2) {
        int m = s1.length(), n = s2.length();
        Boolean[][][] dp = new Boolean[m + 1][n + 1][2000];
        return dfs(s1, s2, 0, 0, 0, dp);
    }

    private boolean dfs(String s1, String s2, int i, int j, int diff, Boolean[][][] dp) {
        if (i == s1.length() && j == s2.length()) {
            return diff == 0;
        }
        if (dp[i][j][diff + 1000] != null) {
            return dp[i][j][diff + 1000];
        }
        boolean res = false;
        if (i < s1.length()) {
            if (Character.isDigit(s1.charAt(i))) {
                int num = 0;
                for (int k = i; k < s1.length() && Character.isDigit(s1.charAt(k)); k++) {
                    num = num * 10 + (s1.charAt(k) - '0');
                    res |= dfs(s1, s2, k + 1, j, diff - num, dp);
                    if (res) {
                        return dp[i][j][diff + 1000] = res;
                    }
                }
            } else {
                if (diff > 0) {
                    res |= dfs(s1, s2, i + 1, j, diff - 1, dp);
                } else if (diff == 0 && j < s2.length() && !Character.isDigit(s2.charAt(j)) && s1.charAt(i) == s2.charAt(j)) {
                    res |= dfs(s1, s2, i + 1, j + 1, diff, dp);
                }
            }
        }
        if (!res && j < s2.length()) {
            if (Character.isDigit(s2.charAt(j))) {
                int num = 0;
                for (int k = j; k < s2.length() && Character.isDigit(s2.charAt(k)); k++) {
                    num = num * 10 + (s2.charAt(k) - '0');
                    res |= dfs(s1, s2, i, k + 1, diff + num, dp);
                    if (res) {
                        return dp[i][j][diff + 1000] = res;
                    }
                }
            } else {
                if (diff < 0) {
                    res |= dfs(s1, s2, i, j + 1, diff + 1, dp);
                } else if (diff == 0 && i < s1.length() && !Character.isDigit(s1.charAt(i)) && s1.charAt(i) == s2.charAt(j)) {
                    res |= dfs(s1, s2, i + 1, j + 1, diff, dp);
                }
            }
        }
        return dp[i][j][diff + 1000] = res;
    }
}