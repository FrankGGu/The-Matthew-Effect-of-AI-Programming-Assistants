import java.util.*;

class Solution {
    public int[] shortestDistance(int n, int[][] edges, int[][] queries) {
        int[] result = new int[queries.length];
        Arrays.fill(result, -1);

        for (int i = 0; i < queries.length; i++) {
            int[][] currentEdges = new int[edges.length + 1][2];
            for (int j = 0; j < edges.length; j++) {
                currentEdges[j][0] = edges[j][0];
                currentEdges[j][1] = edges[j][1];
            }
            currentEdges[edges.length][0] = queries[i][0];
            currentEdges[edges.length][1] = queries[i][1];

            int[][] dist = new int[n][n];
            for (int j = 0; j < n; j++) {
                Arrays.fill(dist[j], Integer.MAX_VALUE);
                dist[j][j] = 0;
            }

            for (int[] edge : currentEdges) {
                dist[edge[0]][edge[1]] = 1;
                dist[edge[1]][edge[0]] = 1;
            }

            for (int k = 0; k < n; k++) {
                for (int u = 0; u < n; u++) {
                    for (int v = 0; v < n; v++) {
                        if (dist[u][k] != Integer.MAX_VALUE && dist[k][v] != Integer.MAX_VALUE &&
                            dist[u][k] + dist[k][v] < dist[u][v]) {
                            dist[u][v] = dist[u][k] + dist[k][v];
                        }
                    }
                }
            }

            if (dist[0][n - 1] != Integer.MAX_VALUE) {
                result[i] = dist[0][n - 1];
            }
        }

        return result;
    }
}