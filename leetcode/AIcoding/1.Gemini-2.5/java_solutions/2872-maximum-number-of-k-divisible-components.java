import java.util.ArrayList;
import java.util.List;

class Solution {
    private int count;
    private long K_divisor;

    public int maxKDivisibleComponents(int n, int[][] edges, int[] values, int k) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj.get(u).add(v);
            adj.get(v).add(u);
        }

        count = 0;
        K_divisor = k; 

        dfs(0, -1, adj, values);

        return count;
    }

    private long dfs(int u, int p, List<List<Integer>> adj, int[] values) {
        long currentSum = values[u];

        for (int v : adj.get(u)) {
            if (v == p) {
                continue;
            }
            currentSum += dfs(v, u, adj, values);
        }

        if (currentSum % K_divisor == 0) {
            count++;
            return 0;
        } else {
            return currentSum;
        }
    }
}