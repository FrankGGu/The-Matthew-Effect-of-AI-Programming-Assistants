class Solution {
    public int[] shortestDistance(int n, int[][] roads, int[][] queries) {
        int[][] dist = new int[n][n];
        for (int i = 0; i < n; i++) {
            Arrays.fill(dist[i], Integer.MAX_VALUE / 2);
            dist[i][i] = 0;
        }
        for (int[] road : roads) {
            int u = road[0], v = road[1], w = road[2];
            dist[u][v] = Math.min(dist[u][v], w);
            dist[v][u] = Math.min(dist[v][u], w);
        }
        for (int k = 0; k < n; k++) {
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    dist[i][j] = Math.min(dist[i][j], dist[i][k] + dist[k][j]);
                }
            }
        }
        int[] res = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int u = queries[i][0], v = queries[i][1], w = queries[i][2];
            int minDist = dist[u][v];
            for (int k = 0; k < n; k++) {
                minDist = Math.min(minDist, dist[u][k] + w + dist[k][v]);
                minDist = Math.min(minDist, dist[v][k] + w + dist[k][u]);
            }
            res[i] = minDist;
        }
        return res;
    }
}