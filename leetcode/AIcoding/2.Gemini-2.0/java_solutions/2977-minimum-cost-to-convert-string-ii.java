class Solution {
    public long minimumCost(String source, String target, String[] original, String[] changed, int[] cost) {
        int n = source.length();
        int k = original.length;
        int maxLen = 0;
        for (String s : original) {
            maxLen = Math.max(maxLen, s.length());
        }

        int[][] dist = new int[26 * 26][26 * 26];
        for (int i = 0; i < 26 * 26; i++) {
            for (int j = 0; j < 26 * 26; j++) {
                dist[i][j] = (i == j) ? 0 : Integer.MAX_VALUE;
            }
        }

        for (int i = 0; i < k; i++) {
            int u = strToInt(original[i]);
            int v = strToInt(changed[i]);
            dist[u][v] = Math.min(dist[u][v], cost[i]);
        }

        for (int mid = 0; mid < 26 * 26; mid++) {
            for (int i = 0; i < 26 * 26; i++) {
                for (int j = 0; j < 26 * 26; j++) {
                    if (dist[i][mid] != Integer.MAX_VALUE && dist[mid][j] != Integer.MAX_VALUE) {
                        dist[i][j] = Math.min(dist[i][j], dist[i][mid] + dist[mid][j]);
                    }
                }
            }
        }

        long[] dp = new long[n + 1];
        for (int i = 1; i <= n; i++) {
            dp[i] = dp[i - 1] + (source.charAt(i - 1) == target.charAt(i - 1) ? 0 : Integer.MAX_VALUE);

            for (int j = 0; j < k; j++) {
                int len = original[j].length();
                if (i >= len) {
                    String sub = source.substring(i - len, i);
                    if (sub.equals(original[j])) {
                        int u = strToInt(original[j]);
                        int v = strToInt(changed[j]);
                        if (dist[u][v] != Integer.MAX_VALUE && dp[i - len] != Integer.MAX_VALUE) {
                            dp[i] = Math.min(dp[i], dp[i - len] + dist[u][v]);
                        }
                    }
                }
            }
        }

        return dp[n] == Integer.MAX_VALUE ? -1 : dp[n];
    }

    private int strToInt(String s) {
        int result = 0;
        for (char c : s.toCharArray()) {
            result = result * 26 + (c - 'a');
        }
        return result;
    }
}