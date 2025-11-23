import java.util.*;

class Solution {
    public int[] minEdgeReversals(int n, int[][] edges) {
        List<List<int[]>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj.get(u).add(new int[]{v, 0});
            adj.get(v).add(new int[]{u, 1});
        }

        int[] ans = new int[n];
        int[] count = new int[1];

        dfs(0, -1, adj, count);
        ans[0] = count[0];

        Queue<Integer> q = new LinkedList<>();
        q.offer(0);
        boolean[] visited = new boolean[n];
        visited[0] = true;

        while (!q.isEmpty()) {
            int u = q.poll();
            for (int[] neighbor : adj.get(u)) {
                int v = neighbor[0];
                int rev = neighbor[1];
                if (!visited[v]) {
                    visited[v] = true;
                    ans[v] = ans[u] + (rev == 0 ? 1 : -1);
                    q.offer(v);
                }
            }
        }

        return ans;
    }

    private void dfs(int u, int parent, List<List<int[]>> adj, int[] count) {
        for (int[] neighbor : adj.get(u)) {
            int v = neighbor[0];
            int rev = neighbor[1];
            if (v != parent) {
                count[0] += rev;
                dfs(v, u, adj, count);
            }
        }
    }
}