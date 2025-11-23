import java.util.ArrayList;
import java.util.List;

class Solution {
    private List<List<Integer>> adj;
    private char[] labelsChar;
    private int[] ans;

    public int[] countSubTrees(int n, int[][] edges, String labels) {
        adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        labelsChar = labels.toCharArray();
        ans = new int[n];

        dfs(0, -1);

        return ans;
    }

    private int[] dfs(int u, int p) {
        int[] counts = new int[26];

        for (int v : adj.get(u)) {
            if (v == p) {
                continue;
            }
            int[] childCounts = dfs(v, u);
            for (int i = 0; i < 26; i++) {
                counts[i] += childCounts[i];
            }
        }

        counts[labelsChar[u] - 'a']++;
        ans[u] = counts[labelsChar[u] - 'a'];

        return counts;
    }
}