public class Solution {
    public boolean canMove(String[] board, String color) {
        int n = board.length;
        boolean[][] visited = new boolean[n][n];
        int[] directions = color.equals("white") ? new int[]{-1, 1} : new int[]{1, -1};

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (board[i].charAt(j) == 'K' && !visited[i][j]) {
                    return dfs(board, visited, i, j, directions[0], directions[1]);
                }
            }
        }
        return false;
    }

    private boolean dfs(String[] board, boolean[][] visited, int x, int y, int dx, int dy) {
        if (x < 0 || x >= board.length || y < 0 || y >= board.length || visited[x][y]) {
            return false;
        }
        visited[x][y] = true;
        if (board[x].charAt(y) == 'E') {
            return true;
        }
        return dfs(board, visited, x + dx, y + dy, dx, dy) || dfs(board, visited, x, y + dy, dx, dy);
    }
}