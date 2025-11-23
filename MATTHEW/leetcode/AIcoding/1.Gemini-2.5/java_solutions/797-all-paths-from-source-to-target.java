class Solution {
    public List<List<Integer>> allPathsSourceTarget(int[][] graph) {
        List<List<Integer>> result = new ArrayList<>();
        List<Integer> currentPath = new ArrayList<>();

        dfs(graph, 0, graph.length - 1, currentPath, result);

        return result;
    }

    private void dfs(int[][] graph, int node, int target, List<Integer> currentPath, List<List<Integer>> result) {
        currentPath.add(node);

        if (node == target) {
            result.add(new ArrayList<>(currentPath));
        } else {
            for (int neighbor : graph[node]) {
                dfs(graph, neighbor, target, currentPath, result);
            }
        }

        currentPath.remove(currentPath.size() - 1);
    }
}