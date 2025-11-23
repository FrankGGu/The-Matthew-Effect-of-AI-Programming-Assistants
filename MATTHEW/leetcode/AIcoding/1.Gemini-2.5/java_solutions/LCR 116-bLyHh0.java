class Solution {
    public int findCircleNum(int[][] isConnected) {
        int n = isConnected.length;
        boolean[] visited = new boolean[n];
        int provinces = 0;

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                provinces++;
                dfs(i, n, isConnected, visited);
            }
        }

        return provinces;
    }

    private void dfs(int city, int n, int[][] isConnected, boolean[] visited) {
        visited[city] = true;
        for (int j = 0; j < n; j++) {
            if (isConnected[city][j] == 1 && !visited[j]) {
                dfs(j, n, isConnected, visited);
            }
        }
    }
}