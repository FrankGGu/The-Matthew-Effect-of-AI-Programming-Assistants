class Solution {
    private int[] count;
    private int[] result;
    private List<List<Integer>> graph;

    public int[] sumOfDistancesInTree(int n, int[][] edges) {
        count = new int[n];
        result = new int[n];
        graph = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }

        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }

        dfs1(0, -1);
        dfs2(0, -1);

        return result;
    }

    private void dfs1(int node, int parent) {
        count[node] = 1;
        for (int neighbor : graph.get(node)) {
            if (neighbor != parent) {
                dfs1(neighbor, node);
                count[node] += count[neighbor];
                result[node] += result[neighbor] + count[neighbor];
            }
        }
    }

    private void dfs2(int node, int parent) {
        for (int neighbor : graph.get(node)) {
            if (neighbor != parent) {
                result[neighbor] = result[node] - count[neighbor] + (count.length - count[neighbor]);
                dfs2(neighbor, node);
            }
        }
    }
}