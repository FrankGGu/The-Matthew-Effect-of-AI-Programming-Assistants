class Solution {
    public int minimumTotalPrice(int n, int[][] edges, int[] price, int[][] trips) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }

        int[] count = new int[n];
        for (int[] trip : trips) {
            int start = trip[0], end = trip[1];
            List<Integer> path = new ArrayList<>();
            dfs(graph, start, -1, end, path);
            for (int node : path) {
                count[node]++;
            }
        }

        int[] res = dp(graph, 0, -1, price, count);
        return Math.min(res[0], res[1]);
    }

    private boolean dfs(List<List<Integer>> graph, int node, int parent, int end, List<Integer> path) {
        path.add(node);
        if (node == end) {
            return true;
        }
        for (int neighbor : graph.get(node)) {
            if (neighbor != parent && dfs(graph, neighbor, node, end, path)) {
                return true;
            }
        }
        path.remove(path.size() - 1);
        return false;
    }

    private int[] dp(List<List<Integer>> graph, int node, int parent, int[] price, int[] count) {
        int fullPrice = price[node] * count[node];
        int halfPrice = fullPrice / 2;

        for (int neighbor : graph.get(node)) {
            if (neighbor != parent) {
                int[] child = dp(graph, neighbor, node, price, count);
                fullPrice += Math.min(child[0], child[1]);
                halfPrice += child[0];
            }
        }

        return new int[]{fullPrice, halfPrice};
    }
}