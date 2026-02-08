class Solution {
    private int maxQuality = 0;

    public int maximalPathQuality(int[] values, int[][] edges, int maxTime) {
        int n = values.length;
        List<List<int[]>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1], time = edge[2];
            graph.get(u).add(new int[]{v, time});
            graph.get(v).add(new int[]{u, time});
        }
        int[] visited = new int[n];
        visited[0]++;
        dfs(0, values[0], maxTime, values, graph, visited);
        return maxQuality;
    }

    private void dfs(int node, int currentQuality, int remainingTime, int[] values, List<List<int[]>> graph, int[] visited) {
        if (node == 0) {
            maxQuality = Math.max(maxQuality, currentQuality);
        }
        for (int[] neighbor : graph.get(node)) {
            int nextNode = neighbor[0];
            int timeCost = neighbor[1];
            if (remainingTime >= timeCost) {
                if (visited[nextNode] == 0) {
                    currentQuality += values[nextNode];
                }
                visited[nextNode]++;
                dfs(nextNode, currentQuality, remainingTime - timeCost, values, graph, visited);
                visited[nextNode]--;
                if (visited[nextNode] == 0) {
                    currentQuality -= values[nextNode];
                }
            }
        }
    }
}