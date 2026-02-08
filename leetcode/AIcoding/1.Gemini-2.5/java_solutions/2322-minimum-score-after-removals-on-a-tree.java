import java.util.*;

class Solution {
    List<List<Integer>> adj;
    int[] nums;
    int[] subtreeXor;
    int[] tin;
    int[] tout;
    int timer;
    int totalXorSum;

    public int minimumScore(int[] nums, int[][] edges) {
        int n = nums.length;
        this.nums = nums;
        adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
            totalXorSum ^= nums[i];
        }

        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        subtreeXor = new int[n];
        tin = new int[n];
        tout = new int[n];
        timer = 0;

        dfs(0, -1);

        int minScore = Integer.MAX_VALUE;

        for (int i = 1; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int x1, x2, x3;

                if (isAncestor(i, j)) {
                    x1 = subtreeXor[j];
                    x2 = subtreeXor[i] ^ subtreeXor[j];
                    x3 = totalXorSum ^ subtreeXor[i];
                } else if (isAncestor(j, i)) {
                    x1 = subtreeXor[i];
                    x2 = subtreeXor[j] ^ subtreeXor[i];
                    x3 = totalXorSum ^ subtreeXor[j];
                } else {
                    x1 = subtreeXor[i];
                    x2 = subtreeXor[j];
                    x3 = totalXorSum ^ subtreeXor[i] ^ subtreeXor[j];
                }

                int currentMax = Math.max(x1, Math.max(x2, x3));
                int currentMin = Math.min(x1, Math.min(x2, x3));
                minScore = Math.min(minScore, currentMax - currentMin);
            }
        }

        return minScore;
    }

    private void dfs(int u, int p) {
        tin[u] = timer++;
        subtreeXor[u] = nums[u];

        for (int v : adj.get(u)) {
            if (v == p) {
                continue;
            }
            dfs(v, u);
            subtreeXor[u] ^= subtreeXor[v];
        }
        tout[u] = timer++;
    }

    private boolean isAncestor(int u, int v) {
        return tin[u] <= tin[v] && tout[u] >= tout[v];
    }
}