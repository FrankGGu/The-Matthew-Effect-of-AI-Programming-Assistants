import java.util.*;

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

        return dfs(0, -1, adj, hasApple);
    }

    private int dfs(int node, int parent, List<List<Integer>> adj, List<Boolean> hasApple) {
        int time = 0;
        for (int neighbor : adj.get(node)) {
            if (neighbor != parent) {
                int childTime = dfs(neighbor, node, adj, hasApple);
                if (childTime > 0 || hasApple.get(neighbor)) {
                    time += 2 + childTime;
                }
            }
        }
        return time;
    }
}