class Solution {
    public long minimumCost(String source, String target, String[] original, String[] changed, int[] cost) {
        Map<String, Integer> strToId = new HashMap<>();
        int id = 0;
        for (String s : original) {
            if (!strToId.containsKey(s)) {
                strToId.put(s, id++);
            }
        }
        for (String s : changed) {
            if (!strToId.containsKey(s)) {
                strToId.put(s, id++);
            }
        }

        int n = strToId.size();
        long[][] dist = new long[n][n];
        for (int i = 0; i < n; i++) {
            Arrays.fill(dist[i], Long.MAX_VALUE / 2);
            dist[i][i] = 0;
        }

        for (int i = 0; i < original.length; i++) {
            int u = strToId.get(original[i]);
            int v = strToId.get(changed[i]);
            dist[u][v] = Math.min(dist[u][v], cost[i]);
        }

        for (int k = 0; k < n; k++) {
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    if (dist[i][k] + dist[k][j] < dist[i][j]) {
                        dist[i][j] = dist[i][k] + dist[k][j];
                    }
                }
            }
        }

        int m = source.length();
        long[] dp = new long[m + 1];
        Arrays.fill(dp, Long.MAX_VALUE / 2);
        dp[0] = 0;

        for (int i = 0; i < m; i++) {
            if (dp[i] == Long.MAX_VALUE / 2) continue;
            if (source.charAt(i) == target.charAt(i)) {
                dp[i + 1] = Math.min(dp[i + 1], dp[i]);
            }
            for (int j = i + 1; j <= m; j++) {
                String subSource = source.substring(i, j);
                String subTarget = target.substring(i, j);
                if (strToId.containsKey(subSource) && strToId.containsKey(subTarget)) {
                    int u = strToId.get(subSource);
                    int v = strToId.get(subTarget);
                    if (dist[u][v] < Long.MAX_VALUE / 2) {
                        dp[j] = Math.min(dp[j], dp[i] + dist[u][v]);
                    }
                }
            }
        }

        return dp[m] == Long.MAX_VALUE / 2 ? -1 : dp[m];
    }
}