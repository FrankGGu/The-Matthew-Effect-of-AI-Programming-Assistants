import java.util.*;

class Solution {

    List<List<Integer>> adj;
    int[] price;
    int[] frequencies;
    long[][] memo; // memo[node][state]: state 0 for original price, 1 for halved price

    public long minimizeTotalPrice(int n, int[][] edges, int[] price, int[][] trips) {
        this.price = price;
        this.frequencies = new int[n];
        this.adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        for (int[] trip : trips) {
            int start = trip[0];
            int end = trip[1];

            int[] parentMap = new int[n];
            Arrays.fill(parentMap, -1);
            Queue<Integer> q = new LinkedList<>();
            q.offer(start);
            boolean[] visited = new boolean[n];
            visited[start] = true;

            while (!q.isEmpty()) {
                int curr = q.poll();
                if (curr == end) break;
                for (int neighbor : adj.get(curr)) {
                    if (!visited[neighbor]) {
                        visited[neighbor] = true;
                        parentMap[neighbor] = curr;
                        q.offer(neighbor);
                    }
                }
            }

            int curr = end;
            while (curr != -1) {
                frequencies[curr]++;
                if (curr == start) break;
                curr = parentMap[curr];
            }
        }

        memo = new long[n][2];
        for (long[] row : memo) {
            Arrays.fill(row, -1L);
        }

        long[] result = dfsDP(0, -1);
        return Math.min(result[0], result[1]);
    }

    private long[] dfsDP(int u, int p) {
        if (memo[u][0] != -1) {
            return memo[u];
        }

        long costIfOriginal = (long) frequencies[u] * price[u];
        long costIfHalved = (long) frequencies[u] * (price[u] / 2);

        for (int v : adj.get(u)) {
            if (v == p) {
                continue;
            }
            long[] childCosts = dfsDP(v, u);

            costIfOriginal += Math.min(childCosts[0], childCosts[1]);

            costIfHalved += childCosts[0];
        }

        memo[u][0] = costIfOriginal;
        memo[u][1] = costIfHalved;
        return new long[]{costIfOriginal, costIfHalved};
    }
}