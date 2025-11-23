class Solution {
    public int countSubtrees(int n, int[][] edges) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }

        int[] maxDistances = new int[n];
        boolean[] visited = new boolean[n];
        int[] subtreeCount = new int[n];

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                dfs(graph, i, visited, maxDistances, subtreeCount);
            }
        }

        int count = 0;
        for (int i = 0; i < n; i++) {
            count += subtreeCount[i];
        }
        return count;
    }

    private int dfs(List<List<Integer>> graph, int node, boolean[] visited, int[] maxDistances, int[] subtreeCount) {
        visited[node] = true;
        int maxDistance = 0;
        int childCount = 0;

        for (int neighbor : graph.get(node)) {
            if (!visited[neighbor]) {
                int distance = dfs(graph, neighbor, visited, maxDistances, subtreeCount);
                maxDistance = Math.max(maxDistance, distance + 1);
                childCount++;
            }
        }

        maxDistances[node] = maxDistance;
        subtreeCount[node] = childCount;
        return maxDistance;
    }
}