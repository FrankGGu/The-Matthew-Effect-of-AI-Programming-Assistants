import java.util.*;

class Solution {
    public double frogPosition(int n, int[][] edges, int t, int target) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i <= n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        double[] prob = new double[n + 1];
        prob[1] = 1.0;
        boolean[] visited = new boolean[n + 1];
        visited[1] = true;

        Queue<Integer> q = new LinkedList<>();
        q.offer(1);

        for (int i = 0; i < t; i++) {
            int size = q.size();
            for (int j = 0; j < size; j++) {
                int u = q.poll();
                int count = 0;
                for (int v : adj.get(u)) {
                    if (!visited[v]) {
                        count++;
                    }
                }

                if (count == 0) {
                    continue;
                }

                for (int v : adj.get(u)) {
                    if (!visited[v]) {
                        prob[v] = prob[u] / count;
                        visited[v] = true;
                        q.offer(v);
                    }
                }
                prob[u] = 0.0;
            }
        }

        return prob[target];
    }
}