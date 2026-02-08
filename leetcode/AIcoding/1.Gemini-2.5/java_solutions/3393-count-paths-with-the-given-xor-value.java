import java.util.*;

class Solution {
    long totalPaths;
    Map<Integer, Integer> xorFreq;
    List<List<Integer>> adj;
    int[] nodeValues;
    int targetK;

    public long countPathsWithGivenXORValue(int n, int[][] edges, int[] nodeValues, int k) {
        this.nodeValues = nodeValues;
        this.targetK = k;
        this.totalPaths = 0;
        this.xorFreq = new HashMap<>();
        this.adj = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj.get(u).add(v);
            adj.get(v).add(u);
        }

        xorFreq.put(0, 1);

        dfs(0, -1, 0);

        return totalPaths;
    }

    private void dfs(int u, int parent, int currentXorSum) {
        currentXorSum ^= nodeValues[u];

        totalPaths += xorFreq.getOrDefault(currentXorSum ^ targetK, 0);

        xorFreq.put(currentXorSum, xorFreq.getOrDefault(currentXorSum, 0) + 1);

        for (int v : adj.get(u)) {
            if (v != parent) {
                dfs(v, u, currentXorSum);
            }
        }

        xorFreq.put(currentXorSum, xorFreq.get(currentXorSum) - 1);
    }
}