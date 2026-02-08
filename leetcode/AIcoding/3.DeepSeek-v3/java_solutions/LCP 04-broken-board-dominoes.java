class Solution {
    public int domino(int n, int m, int[][] broken) {
        int[][] board = new int[n][m];
        for (int[] b : broken) {
            board[b[0]][b[1]] = -1;
        }

        int[] match = new int[n * m];
        Arrays.fill(match, -1);
        boolean[] visited;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if ((i + j) % 2 == 1 || board[i][j] == -1) continue;
                visited = new boolean[n * m];
                if (dfs(board, match, visited, i, j, n, m)) {
                    // do nothing
                }
            }
        }

        int res = 0;
        for (int num : match) {
            if (num != -1) res++;
        }
        return res;
    }

    private boolean dfs(int[][] board, int[] match, boolean[] visited, int i, int j, int n, int m) {
        int[][] dirs = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};
        int pos = i * m + j;
        for (int[] d : dirs) {
            int x = i + d[0];
            int y = j + d[1];
            if (x < 0 || x >= n || y < 0 || y >= m || board[x][y] == -1) continue;
            int nextPos = x * m + y;
            if (visited[nextPos]) continue;
            visited[nextPos] = true;
            if (match[nextPos] == -1 || dfs(board, match, visited, match[nextPos] / m, match[nextPos] % m, n, m)) {
                match[nextPos] = pos;
                return true;
            }
        }
        return false;
    }
}