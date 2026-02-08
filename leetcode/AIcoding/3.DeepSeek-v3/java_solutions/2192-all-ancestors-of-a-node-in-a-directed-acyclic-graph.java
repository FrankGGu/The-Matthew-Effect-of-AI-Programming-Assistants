class Solution {
    public List<List<Integer>> getAncestors(int n, int[][] edges) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
        }

        List<Set<Integer>> ancestors = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            ancestors.add(new HashSet<>());
        }

        for (int i = 0; i < n; i++) {
            dfs(i, i, adj, ancestors);
        }

        List<List<Integer>> result = new ArrayList<>();
        for (Set<Integer> set : ancestors) {
            List<Integer> list = new ArrayList<>(set);
            Collections.sort(list);
            result.add(list);
        }
        return result;
    }

    private void dfs(int u, int ancestor, List<List<Integer>> adj, List<Set<Integer>> ancestors) {
        for (int v : adj.get(u)) {
            if (!ancestors.get(v).contains(ancestor)) {
                ancestors.get(v).add(ancestor);
                dfs(v, ancestor, adj, ancestors);
            }
        }
    }
}