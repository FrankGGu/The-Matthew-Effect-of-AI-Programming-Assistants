class Solution {
    public boolean hasPath(int[][] maze, int[] start, int[] destination) {
        int m = maze.length;
        int n = maze[0].length;
        boolean[][] visited = new boolean[m][n];
        int[][] directions = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

        return dfs(maze, start, destination, visited, directions);
    }

    private boolean dfs(int[][] maze, int[] start, int[] destination, boolean[][] visited, int[][] directions) {
        int row = start[0];
        int col = start[1];

        if (visited[row][col]) {
            return false;
        }

        if (row == destination[0] && col == destination[1]) {
            return true;
        }

        visited[row][col] = true;

        for (int[] dir : directions) {
            int newRow = row;
            int newCol = col;

            while (newRow >= 0 && newRow < maze.length && newCol >= 0 && newCol < maze[0].length && maze[newRow][newCol] == 0) {
                newRow += dir[0];
                newCol += dir[1];
            }

            newRow -= dir[0];
            newCol -= dir[1];

            if (dfs(maze, new int[]{newRow, newCol}, destination, visited, directions)) {
                return true;
            }
        }

        return false;
    }
}