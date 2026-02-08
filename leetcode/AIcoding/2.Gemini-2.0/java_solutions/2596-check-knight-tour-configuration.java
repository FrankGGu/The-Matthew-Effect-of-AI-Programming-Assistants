class Solution {
    public boolean checkKnightTourConfiguration(int[][] grid) {
        int n = grid.length;
        int m = grid[0].length;
        if (grid[0][0] != 0) {
            return false;
        }

        int[][] moves = {{-2, -1}, {-2, 1}, {-1, -2}, {-1, 2}, {1, -2}, {1, 2}, {2, -1}, {2, 1}};
        int x = 0;
        int y = 0;

        for (int i = 1; i < n * m; i++) {
            boolean found = false;
            for (int[] move : moves) {
                int nextX = x + move[0];
                int nextY = y + move[1];

                if (nextX >= 0 && nextX < n && nextY >= 0 && nextY < m && grid[nextX][nextY] == i) {
                    x = nextX;
                    y = nextY;
                    found = true;
                    break;
                }
            }
            if (!found) {
                return false;
            }
        }

        return true;
    }
}