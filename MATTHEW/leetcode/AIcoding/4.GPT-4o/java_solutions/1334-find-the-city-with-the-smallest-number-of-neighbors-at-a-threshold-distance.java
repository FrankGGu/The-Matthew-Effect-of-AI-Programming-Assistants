import java.util.*;

class Solution {
    public int findTheCity(int n, int[][] edges, int distanceThreshold) {
        int[][] dist = new int[n][n];
        for (int[] row : dist) Arrays.fill(row, Integer.MAX_VALUE);
        for (int i = 0; i < n; i++) dist[i][i] = 0;

        for (int[] edge : edges) {
            dist[edge[0]][edge[1]] = edge[2];
            dist[edge[1]][edge[0]] = edge[2];
        }

        for (int k = 0; k < n; k++) {
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    if (dist[i][k] != Integer.MAX_VALUE && dist[k][j] != Integer.MAX_VALUE) {
                        dist[i][j] = Math.min(dist[i][j], dist[i][k] + dist[k][j]);
                    }
                }
            }
        }

        int cityWithMinNeighbors = -1;
        int minNeighborsCount = Integer.MAX_VALUE;

        for (int i = 0; i < n; i++) {
            int neighborsCount = 0;
            for (int j = 0; j < n; j++) {
                if (dist[i][j] <= distanceThreshold) {
                    neighborsCount++;
                }
            }
            if (neighborsCount <= minNeighborsCount) {
                minNeighborsCount = neighborsCount;
                cityWithMinNeighbors = i;
            }
        }

        return cityWithMinNeighbors;
    }
}