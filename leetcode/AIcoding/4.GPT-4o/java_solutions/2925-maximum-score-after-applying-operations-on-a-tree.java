class Solution {
    public int maximumScore(int[] nums, int[][] edges) {
        int n = nums.length;
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) graph.add(new ArrayList<>());

        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }

        boolean[] visited = new boolean[n];
        int maxScore = 0;

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                int score = dfs(i, graph, nums, visited);
                maxScore = Math.max(maxScore, score);
            }
        }

        return maxScore;
    }

    private int dfs(int node, List<List<Integer>> graph, int[] nums, boolean[] visited) {
        visited[node] = true;
        int sum = nums[node];

        for (int neighbor : graph.get(node)) {
            if (!visited[neighbor]) {
                sum += dfs(neighbor, graph, nums, visited);
            }
        }

        return sum;
    }
}