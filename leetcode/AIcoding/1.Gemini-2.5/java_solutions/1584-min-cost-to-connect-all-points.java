import java.util.Arrays;

class Solution {
    public int minCostConnectPoints(int[][] points) {
        int n = points.length;
        if (n <= 1) {
            return 0;
        }

        int[] minDist = new int[n];
        Arrays.fill(minDist, Integer.MAX_VALUE);
        boolean[] visited = new boolean[n];

        minDist[0] = 0; // Start with point 0
        int totalMinCost = 0;
        int edgesConnected = 0;

        while (edgesConnected < n) {
            int u = -1;
            int currentMinDist = Integer.MAX_VALUE;

            // Find the unvisited vertex with the smallest distance to the MST
            for (int i = 0; i < n; i++) {
                if (!visited[i] && minDist[i] < currentMinDist) {
                    currentMinDist = minDist[i];
                    u = i;
                }
            }

            // If no unvisited vertex found (should not happen if graph is connected)
            if (u == -1) {
                break;
            }

            visited[u] = true;
            totalMinCost += currentMinDist;
            edgesConnected++;

            // Update distances for neighbors of u
            for (int v = 0; v < n; v++) {
                if (!visited[v]) {
                    int distance = Math.abs(points[u][0] - points[v][0]) + Math.abs(points[u][1] - points[v][1]);
                    minDist[v] = Math.min(minDist[v], distance);
                }
            }
        }

        return totalMinCost;
    }
}