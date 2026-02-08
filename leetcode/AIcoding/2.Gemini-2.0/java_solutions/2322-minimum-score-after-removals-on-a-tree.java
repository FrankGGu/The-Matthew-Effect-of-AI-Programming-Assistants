import java.util.*;

class Solution {
    private int n;
    private List<List<Integer>> adj;
    private int[] values;
    private int[] inTime;
    private int[] outTime;
    private int timer;
    private int[] xor;

    public int minimumScore(int[] nums, int[][] edges) {
        n = nums.length;
        adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }
        values = nums;
        inTime = new int[n];
        outTime = new int[n];
        xor = new int[n];
        timer = 0;

        dfs(0, -1, 0);

        int ans = Integer.MAX_VALUE;
        for (int i = 1; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int a, b, c;
                if (isAncestor(i, j)) {
                    a = xor[0] ^ xor[i];
                    b = xor[j];
                    c = xor[i] ^ xor[j];
                } else if (isAncestor(j, i)) {
                    a = xor[0] ^ xor[j];
                    b = xor[i];
                    c = xor[j] ^ xor[i];
                } else {
                    a = xor[i];
                    b = xor[j];
                    c = xor[0] ^ xor[i] ^ xor[j];
                }
                ans = Math.min(ans, Math.max(a, Math.max(b, c)) - Math.min(a, Math.min(b, c)));
            }
        }
        return ans;
    }

    private void dfs(int node, int parent, int currentXor) {
        inTime[node] = timer++;
        xor[node] = currentXor ^ values[node];

        for (int neighbor : adj.get(node)) {
            if (neighbor != parent) {
                dfs(neighbor, node, xor[node]);
            }
        }

        outTime[node] = timer++;
    }

    private boolean isAncestor(int u, int v) {
        return inTime[u] <= inTime[v] && outTime[u] >= outTime[v];
    }
}