import java.util.ArrayList;
import java.util.List;

class Solution {
    public int minTime(int n, int[][] edges, List<Boolean> hasApple) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        int[] totalTime = new int[1];
        dfs(0, -1, adj, hasApple, totalTime);

        return totalTime[0];
    }

    private boolean dfs(int u, int p, List<List<Integer>> adj, List<Boolean> hasApple, int[] totalTime) {
        boolean hasAppleInSubtree = hasApple.get(u);

        for (int v : adj.get(u)) {
            if (v == p) {
                continue;
            }
            if (dfs(v, u, adj, hasApple, totalTime)) {
                totalTime[0] += 2; 
                hasAppleInSubtree = true;
            }
        }
        return hasAppleInSubtree;
    }
}