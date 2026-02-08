class Solution {
    public int[] countSubTrees(int n, int[][] edges, String labels) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }
        int[] res = new int[n];
        dfs(0, -1, adj, labels, res);
        return res;
    }

    private int[] dfs(int node, int parent, List<List<Integer>> adj, String labels, int[] res) {
        int[] count = new int[26];
        char c = labels.charAt(node);
        count[c - 'a'] = 1;
        for (int child : adj.get(node)) {
            if (child == parent) continue;
            int[] childCount = dfs(child, node, adj, labels, res);
            for (int i = 0; i < 26; i++) {
                count[i] += childCount[i];
            }
        }
        res[node] = count[c - 'a'];
        return count;
    }
}