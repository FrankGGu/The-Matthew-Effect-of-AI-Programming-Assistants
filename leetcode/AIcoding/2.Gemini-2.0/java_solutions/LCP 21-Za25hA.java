import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

class Solution {
    public boolean canCatch(int n, int startHunter, int startTarget, int[] tunnel) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i <= n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int i = 1; i < n; i++) {
            adj.get(i).add(i + 1);
            adj.get(i + 1).add(i);
        }

        adj.get(tunnel[0]).add(tunnel[1]);
        adj.get(tunnel[1]).add(tunnel[0]);

        int[] hunterDist = bfs(adj, startHunter, n);
        int[] targetDist = bfs(adj, startTarget, n);

        for (int i = 1; i <= n; i++) {
            if (hunterDist[i] <= targetDist[i]) {
                return true;
            }
        }

        return false;
    }

    private int[] bfs(List<List<Integer>> adj, int start, int n) {
        int[] dist = new int[n + 1];
        for (int i = 1; i <= n; i++) {
            dist[i] = Integer.MAX_VALUE;
        }
        dist[start] = 0;

        Queue<Integer> queue = new LinkedList<>();
        queue.offer(start);

        while (!queue.isEmpty()) {
            int u = queue.poll();
            for (int v : adj.get(u)) {
                if (dist[v] == Integer.MAX_VALUE) {
                    dist[v] = dist[u] + 1;
                    queue.offer(v);
                }
            }
        }

        return dist;
    }
}