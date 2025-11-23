class Solution {
    public int mostProfitablePath(int[][] edges, int bob, int[] amount) {
        int n = amount.length;
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            graph.get(u).add(v);
            graph.get(v).add(u);
        }

        int[] parent = new int[n];
        Arrays.fill(parent, -1);
        Queue<Integer> queue = new LinkedList<>();
        queue.offer(0);
        while (!queue.isEmpty()) {
            int u = queue.poll();
            for (int v : graph.get(u)) {
                if (parent[v] == -1 && v != 0) {
                    parent[v] = u;
                    queue.offer(v);
                }
            }
        }

        int[] time = new int[n];
        Arrays.fill(time, Integer.MAX_VALUE);
        int t = 0;
        while (bob != -1) {
            time[bob] = t++;
            bob = parent[bob];
        }

        queue.offer(0);
        int[] profit = new int[n];
        profit[0] = amount[0];
        int res = Integer.MIN_VALUE;
        while (!queue.isEmpty()) {
            int u = queue.poll();
            if (graph.get(u).size() == 1 && u != 0) {
                res = Math.max(res, profit[u]);
            }
            for (int v : graph.get(u)) {
                if (v == parent[u]) continue;
                int newProfit = profit[u];
                if (time[v] > t && time[v] == t) {
                    newProfit += amount[v] / 2;
                } else if (time[v] > t) {
                    newProfit += amount[v];
                }
                profit[v] = newProfit;
                queue.offer(v);
            }
            t++;
        }
        return res;
    }
}