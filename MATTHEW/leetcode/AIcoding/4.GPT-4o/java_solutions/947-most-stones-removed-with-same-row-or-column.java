class Solution {
    public int removeStones(int[][] stones) {
        int n = stones.length;
        boolean[] visited = new boolean[n];
        Map<Integer, List<Integer>> rows = new HashMap<>();
        Map<Integer, List<Integer>> cols = new HashMap();

        for (int i = 0; i < n; i++) {
            rows.computeIfAbsent(stones[i][0], k -> new ArrayList<>()).add(i);
            cols.computeIfAbsent(stones[i][1], k -> new ArrayList<>()).add(i);
        }

        int components = 0;

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                components++;
                dfs(i, visited, rows, cols, stones);
            }
        }

        return n - components;
    }

    private void dfs(int i, boolean[] visited, Map<Integer, List<Integer>> rows, Map<Integer, List<Integer>> cols, int[][] stones) {
        visited[i] = true;
        int r = stones[i][0];
        int c = stones[i][1];

        for (int idx : rows.get(r)) {
            if (!visited[idx]) {
                dfs(idx, visited, rows, cols, stones);
            }
        }

        for (int idx : cols.get(c)) {
            if (!visited[idx]) {
                dfs(idx, visited, rows, cols, stones);
            }
        }
    }
}