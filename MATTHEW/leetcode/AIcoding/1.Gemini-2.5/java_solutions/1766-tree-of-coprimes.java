import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class Solution {

    private List<List<Integer>> adj;
    private int[] nums;
    private int[] ans;
    private int[][] lastSeen; // lastSeen[value] = {depth, node_idx}
    private boolean[][] coprime; // coprime[i][j] is true if gcd(i, j) == 1

    public int[] getCoprimes(int[] nums, int[][] edges) {
        int n = nums.length;
        this.nums = nums;
        this.ans = new int[n];
        Arrays.fill(this.ans, -1);

        this.adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            this.adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        this.lastSeen = new int[51][2];
        for (int i = 0; i <= 50; i++) {
            lastSeen[i][0] = -1; // depth
            lastSeen[i][1] = -1; // node_idx
        }

        precomputeCoprime();

        dfs(0, -1, 0);

        return ans;
    }

    private void precomputeCoprime() {
        coprime = new boolean[51][51];
        for (int i = 1; i <= 50; i++) {
            for (int j = 1; j <= 50; j++) {
                if (gcd(i, j) == 1) {
                    coprime[i][j] = true;
                }
            }
        }
    }

    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    private void dfs(int u, int p, int depth) {
        int val_u = nums[u];
        int maxAncestorDepth = -1;
        int closestAncestorIdx = -1;

        for (int v = 1; v <= 50; v++) {
            if (coprime[val_u][v]) {
                if (lastSeen[v][0] > maxAncestorDepth) {
                    maxAncestorDepth = lastSeen[v][0];
                    closestAncestorIdx = lastSeen[v][1];
                }
            }
        }
        ans[u] = closestAncestorIdx;

        int prevDepth = lastSeen[val_u][0];
        int prevIdx = lastSeen[val_u][1];

        lastSeen[val_u][0] = depth;
        lastSeen[val_u][1] = u;

        for (int neighbor : adj.get(u)) {
            if (neighbor != p) {
                dfs(neighbor, u, depth + 1);
            }
        }

        lastSeen[val_u][0] = prevDepth;
        lastSeen[val_u][1] = prevIdx;
    }
}