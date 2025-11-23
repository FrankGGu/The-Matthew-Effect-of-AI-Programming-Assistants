class Solution {
    public int[] findCrossingPath(int[][] roads) {
        int n = roads.length;
        int[] result = new int[n];
        boolean[] visited = new boolean[n];
        dfs(0, visited, result, roads, 0);
        return result;
    }

    private void dfs(int node, boolean[] visited, int[] result, int[][] roads, int depth) {
        visited[node] = true;
        result[node] = depth;

        for (int nextNode : roads[node]) {
            if (!visited[nextNode]) {
                dfs(nextNode, visited, result, roads, depth + 1);
            }
        }
    }
}