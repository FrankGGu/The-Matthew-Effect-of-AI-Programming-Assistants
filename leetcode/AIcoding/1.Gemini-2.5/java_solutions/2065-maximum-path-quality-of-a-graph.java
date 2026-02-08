import java.util.*;

class Solution {
    int maxQuality = 0;
    int[] values;
    int maxTime;
    List<List<int[]>> adj; // Stores [neighbor, time]

    public int maximalPathQuality(int[] values, int[][] edges, int maxTime) {
        this.values = values;
        this.maxTime = maxTime;
        int n = values.length;

        adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int time = edge[2];
            adj.get(u).add(new int[]{v, time});
            adj.get(v).add(new int[]{u, time});
        }

        int[] visitedCount = new int[n];
        // Start DFS from node 0
        dfs(0, 0, 0, visitedCount);

        return maxQuality;
    }

    private void dfs(int u, int currentTime, int currentQuality, int[] visitedCount) {
        // If this is the first time visiting node 'u' on the current path, add its value to quality
        boolean firstVisit = (visitedCount[u] == 0);
        if (firstVisit) {
            currentQuality += values[u];
        }
        visitedCount[u]++;

        // Update maxQuality if the current path ends at node 0.
        // The problem statement "any path starting at node 0" implies paths can end anywhere.
        // However, common interpretations and example paths often focus on paths that start and end at the source.
        // If the problem meant "any path starting at node 0 and ending anywhere", this update would be `maxQuality = Math.max(maxQuality, currentQuality);`
        // Given the ambiguity, updating only when at node 0 is a safer interpretation based on typical problem examples.
        if (u == 0) {
            maxQuality = Math.max(maxQuality, currentQuality);
        }

        // Explore neighbors
        for (int[] neighbor : adj.get(u)) {
            int v = neighbor[0];
            int travelTime = neighbor[1];

            if (currentTime + travelTime <= maxTime) {
                dfs(v, currentTime + travelTime, currentQuality, visitedCount);
            }
        }

        // Backtrack: decrement visit count for the current node 'u'
        visitedCount[u]--;
    }
}