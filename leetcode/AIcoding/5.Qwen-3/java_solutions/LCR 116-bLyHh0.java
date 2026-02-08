public class Solution {
    public int findCircleNum(int[][] isConnected) {
        int n = isConnected.length;
        boolean[] visited = new boolean[n];
        int provinces = 0;

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                provinces++;
                dfs(i, visited, isConnected);
            }
        }

        return provinces;
    }

    private void dfs(int i, boolean[] visited, int[][] isConnected) {
        visited[i] = true;
        for (int j = 0; j < isConnected[i].length; j++) {
            if (isConnected[i][j] == 1 && !visited[j]) {
                dfs(j, visited, isConnected);
            }
        }
    }
}