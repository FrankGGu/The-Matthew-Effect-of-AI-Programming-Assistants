import java.util.Arrays;

class Solution {
    public int minimizeMax(int n, int[][] edges, int maxTrips) {
        int low = 1, high = 100000;
        int ans = 0;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (check(n, edges, maxTrips, mid)) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        return ans;
    }

    private boolean check(int n, int[][] edges, int maxTrips, int maxWeight) {
        int[] degree = new int[n + 1];
        int[][] adjMatrix = new int[n + 1][n + 1];

        for (int i = 1; i <= n; i++) {
            Arrays.fill(adjMatrix[i], 0);
        }

        for (int[] edge : edges) {
            if (edge[2] <= maxWeight) {
                adjMatrix[edge[0]][edge[1]] = 1;
                adjMatrix[edge[1]][edge[0]] = 1;
            } else {
                 adjMatrix[edge[0]][edge[1]] = 0;
                adjMatrix[edge[1]][edge[0]] = 0;
            }
        }

        for(int i = 1; i <= n; i++){
            degree[i] = 0;
            for(int j = 1; j <= n; j++){
                if(adjMatrix[i][j] == 1) degree[i]++;
            }
        }

        int components = 0;
        boolean[] visited = new boolean[n + 1];
        Arrays.fill(visited, false);

        for (int i = 1; i <= n; i++) {
            if (!visited[i]) {
                components++;
                dfs(i, visited, adjMatrix, n);
            }
        }

        return components <= maxTrips;
    }

    private void dfs(int node, boolean[] visited, int[][] adjMatrix, int n) {
        visited[node] = true;
        for (int i = 1; i <= n; i++) {
            if (adjMatrix[node][i] == 1 && !visited[i]) {
                dfs(i, visited, adjMatrix, n);
            }
        }
    }
}