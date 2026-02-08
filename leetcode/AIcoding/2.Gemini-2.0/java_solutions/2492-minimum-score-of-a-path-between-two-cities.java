import java.util.*;

class Solution {
    public int minScore(int n, int[][] roads) {
        List<List<Pair>> adj = new ArrayList<>();
        for (int i = 0; i <= n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] road : roads) {
            int u = road[0];
            int v = road[1];
            int w = road[2];
            adj.get(u).add(new Pair(v, w));
            adj.get(v).add(new Pair(u, w));
        }

        int minScore = Integer.MAX_VALUE;
        boolean[] visited = new boolean[n + 1];
        Queue<Integer> q = new LinkedList<>();
        q.offer(1);
        visited[1] = true;

        while (!q.isEmpty()) {
            int u = q.poll();

            for (Pair neighbor : adj.get(u)) {
                int v = neighbor.node;
                int w = neighbor.weight;
                minScore = Math.min(minScore, w);

                if (!visited[v]) {
                    visited[v] = true;
                    q.offer(v);
                }
            }
        }

        return minScore;
    }

    private static class Pair {
        int node;
        int weight;

        public Pair(int node, int weight) {
            this.node = node;
            this.weight = weight;
        }
    }
}