class Solution {
    public int maximumMoves(int[] pawns, int[] knights) {
        int n = pawns.length;
        int m = knights.length;
        int[][] adj = new int[n + m][n + m];
        int[] inDegree = new int[n + m];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (knights[i] <= pawns[j]) {
                    adj[i + n][j] = 1;
                    inDegree[j]++;
                }
            }
        }

        int[] dp = new int[n + m];
        int ans = 0;
        Queue<Integer> q = new LinkedList<>();

        for (int i = 0; i < n; i++) {
            if (inDegree[i] == 0) {
                q.offer(i);
            }
        }

        while (!q.isEmpty()) {
            int u = q.poll();
            ans = Math.max(ans, dp[u]);

            for (int v = 0; v < n + m; v++) {
                if (adj[u][v] == 1) {
                    dp[v] = Math.max(dp[v], dp[u] + 1);
                    inDegree[v]--;
                    if (inDegree[v] == 0) {
                        q.offer(v);
                    }
                }
            }
        }

        return ans;
    }
}