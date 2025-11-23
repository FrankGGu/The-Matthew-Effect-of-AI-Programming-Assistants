class Solution {
    public int networkBecomesIdle(int[][] edges, int[] patience) {
        int n = patience.length;
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            graph.get(u).add(v);
            graph.get(v).add(u);
        }

        int[] dist = new int[n];
        Arrays.fill(dist, -1);
        Queue<Integer> queue = new LinkedList<>();
        queue.offer(0);
        dist[0] = 0;

        while (!queue.isEmpty()) {
            int u = queue.poll();
            for (int v : graph.get(u)) {
                if (dist[v] == -1) {
                    dist[v] = dist[u] + 1;
                    queue.offer(v);
                }
            }
        }

        int maxTime = 0;
        for (int i = 1; i < n; i++) {
            int roundTrip = 2 * dist[i];
            int p = patience[i];
            int lastSent = (roundTrip - 1) / p * p;
            int totalTime = lastSent + roundTrip;
            if (totalTime > maxTime) {
                maxTime = totalTime;
            }
        }

        return maxTime + 1;
    }
}