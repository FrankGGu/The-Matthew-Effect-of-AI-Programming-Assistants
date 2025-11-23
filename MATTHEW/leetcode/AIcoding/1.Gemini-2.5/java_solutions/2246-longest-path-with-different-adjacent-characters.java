import java.util.ArrayList;
import java.util.List;

class Solution {
    private List<List<Integer>> adj;
    private String s;
    private int[] ans;

    public int longestPath(int[] parent, String s) {
        int n = parent.length;
        this.s = s;
        this.ans = new int[1];
        this.ans[0] = 1;

        adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int i = 1; i < n; i++) {
            adj.get(i).add(parent[i]);
            adj.get(parent[i]).add(i);
        }

        dfs(0, -1);
        return ans[0];
    }

    private int dfs(int u, int p) {
        int maxLen1 = 0;
        int maxLen2 = 0;

        for (int v : adj.get(u)) {
            if (v == p) {
                continue;
            }

            int childPathLen = dfs(v, u);

            if (s.charAt(v) != s.charAt(u)) {
                if (childPathLen > maxLen1) {
                    maxLen2 = maxLen1;
                    maxLen1 = childPathLen;
                } else if (childPathLen > maxLen2) {
                    maxLen2 = childPathLen;
                }
            }
        }

        ans[0] = Math.max(ans[0], 1 + maxLen1 + maxLen2);

        return 1 + maxLen1;
    }
}