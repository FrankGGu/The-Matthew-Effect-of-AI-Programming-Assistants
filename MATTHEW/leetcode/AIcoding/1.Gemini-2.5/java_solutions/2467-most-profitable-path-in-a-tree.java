import java.util.*;

class Solution {
    List<List<Integer>> adj;
    int[] amount;
    int n;
    long maxProfit;
    boolean[] onAlicePath;

    public long mostProfitablePath(int[][] edges, int[] amount) {
        this.n = amount.length;
        this.amount = amount;
        adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        int[] aliceDist = new int[n];
        Arrays.fill(aliceDist, -1);
        int[] parent = new int[n];
        Arrays.fill(parent, -1);

        Queue<Integer> q = new LinkedList<>();
        q.offer(0);
        aliceDist[0] = 0;

        while (!q.isEmpty()) {
            int u = q.poll();
            for (int v : adj.get(u)) {
                if (v == parent[u]) {
                    continue;
                }
                if (aliceDist[v] == -1) {
                    aliceDist[v] = aliceDist[u] + 1;
                    parent[v] = u;
                    q.offer(v);
                }
            }
        }

        onAlicePath = new boolean[n];
        int targetLeaf = -1;
        int minLeafDist = Integer.MAX_VALUE;

        for (int i = 0; i < n; i++) {
            if (adj.get(i).size() == 1 && i != 0) { 
                if (aliceDist[i] < minLeafDist) {
                    minLeafDist = aliceDist[i];
                    targetLeaf = i;
                }
            }
        }

        int curr = targetLeaf;
        while (curr != -1) {
            onAlicePath[curr] = true;
            curr = parent[curr];
        }

        maxProfit = Long.MIN_VALUE;
        dfs(0, -1, 0);

        return maxProfit;
    }

    private void dfs(int u, int p, long currentProfit) {
        long nodeValueForBob;
        if (onAlicePath[u]) {
            nodeValueForBob = amount[u] / 2;
        } else {
            nodeValueForBob = amount[u];
        }
        currentProfit += nodeValueForBob;

        if (adj.get(u).size() == 1 && u != 0) { 
            maxProfit = Math.max(maxProfit, currentProfit);
            return;
        }

        for (int v : adj.get(u)) {
            if (v != p) {
                dfs(v, u, currentProfit);
            }
        }
    }
}