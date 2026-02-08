class Solution {
    private int rows;
    private int cols;
    private char[][] grid;
    private boolean[][] globalVisited; // Tracks cells that have been part of any completed DFS path
    private boolean[][] currentPathVisited; // Tracks cells currently in the recursion stack of the ongoing DFS

    private int[] dr = {-1, 1, 0, 0}; // Row offsets for Up, Down, Left, Right
    private int[] dc = {0, 0, -1, 1}; // Column offsets for Up, Down, Left, Right

    public boolean containsCycle(char[][] grid) {
        this.grid = grid;
        this.rows = grid.length;
        this.cols = grid[0].length;
        this.globalVisited = new boolean[rows][cols];

        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) {
                if (!globalVisited[r][c]) {
                    // Start a new DFS from this unvisited cell.
                    // Reset currentPathVisited for each new starting point to ensure it only tracks the current path.
                    currentPathVisited = new boolean[rows][cols]; 
                    if (dfs(r, c, -1, -1, grid[r][c])) {
                        return true; // Cycle found
                    }
                }
            }
        }
        return false; // No cycle found in the entire grid
    }

    private boolean dfs(int r, int c, int parentR, int parentC, char charToMatch) {
        globalVisited[r][c] = true;
        currentPathVisited[r][c] = true;

        for (int i = 0; i < 4; i++) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            // Check if neighbor is within grid bounds
            if (nr < 0 || nr >= rows || nc < 0 || nc >= cols) {
                continue;
            }

            // Check if neighbor has the same character
            if (grid[nr][nc] != charToMatch) {
                continue;
            }

            // Skip if the neighbor is the immediate parent (prevents going back and forth on an edge)
            if (nr == parentR && nc == parentC) {
                continue;
            }

            // If the neighbor is already in the current DFS path (recursion stack),
            // it means we've found a back-edge to an ancestor, thus completing a cycle.
            if (currentPathVisited[nr][nc]) {
                return true;
            }

            // If the neighbor has not been globally visited, explore it.
            // This prevents redundant work and ensures each connected component is processed once.
            if (!globalVisited[nr][nc]) {
                if (dfs(nr, nc, r, c, charToMatch)) {
                    return true; // Cycle found deeper in the path
                }
            }
        }

        // Backtrack: remove current cell from the current DFS path.
        // This is crucial for correctly identifying cycles in undirected graphs.
        currentPathVisited[r][c] = false;
        return false; // No cycle found from this path
    }
}