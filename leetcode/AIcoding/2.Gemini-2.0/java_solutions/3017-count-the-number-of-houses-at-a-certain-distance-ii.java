import java.util.*;

class Solution {
    public long[] countOfPairs(int n, int x, int y, int[] u, int[] v) {
        x--;
        y--;
        long[] ans = new long[n];
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int i = 0; i < u.length; i++) {
            adj.get(u[i] - 1).add(v[i] - 1);
            adj.get(v[i] - 1).add(u[i] - 1);
        }

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int dist = bfs(adj, i, j);
                int tunnelDist = Math.min(Math.abs(i - x) + Math.abs(j - y) + 1, Math.abs(i - y) + Math.abs(j - x) + 1);
                dist = Math.min(dist, tunnelDist);
                ans[dist - 1]++;
            }
        }
        return ans;
    }

    private int bfs(List<List<Integer>> adj, int start, int end) {
        int n = adj.size();
        int[] dist = new int[n];
        Arrays.fill(dist, -1);
        Queue<Integer> q = new LinkedList<>();
        q.offer(start);
        dist[start] = 0;

        while (!q.isEmpty()) {
            int u = q.poll();
            if (u == end) {
                return dist[end];
            }
            for (int v : adj.get(u)) {
                if (dist[v] == -1) {
                    dist[v] = dist[u] + 1;
                    q.offer(v);
                }
            }
        }
        return dist[end];
    }
}