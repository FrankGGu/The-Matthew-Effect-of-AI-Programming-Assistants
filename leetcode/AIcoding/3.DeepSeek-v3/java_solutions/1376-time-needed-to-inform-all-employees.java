class Solution {
    public int numOfMinutes(int n, int headID, int[] manager, int[] informTime) {
        Map<Integer, List<Integer>> graph = new HashMap<>();
        for (int i = 0; i < n; i++) {
            if (manager[i] != -1) {
                graph.computeIfAbsent(manager[i], k -> new ArrayList<>()).add(i);
            }
        }
        return dfs(headID, graph, informTime);
    }

    private int dfs(int current, Map<Integer, List<Integer>> graph, int[] informTime) {
        int maxTime = 0;
        if (graph.containsKey(current)) {
            for (int subordinate : graph.get(current)) {
                maxTime = Math.max(maxTime, dfs(subordinate, graph, informTime));
            }
        }
        return maxTime + informTime[current];
    }
}