class Solution {
    public int minEdgeReversals(int n, int[][] edges) {
        List<int[]>[] graph = new List[n];
        for (int i = 0; i < n; i++) {
            graph[i] = new ArrayList<>();
        }
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            graph[u].add(new int[]{v, 0});
            graph[v].add(new int[]{u, 1});
        }

        int[] res = new int[n];
        Arrays.fill(res, -1);
        res[0] = 0;
        Queue<Integer> queue = new LinkedList<>();
        queue.offer(0);

        while (!queue.isEmpty()) {
            int u = queue.poll();
            for (int[] neighbor : graph[u]) {
                int v = neighbor[0];
                int cost = neighbor[1];
                if (res[v] == -1) {
                    res[v] = res[u] + cost;
                    queue.offer(v);
                }
            }
        }

        int minReversals = res[0];
        for (int i = 1; i < n; i++) {
            minReversals = Math.min(minReversals, res[i]);
        }

        return minReversals;
    }
}