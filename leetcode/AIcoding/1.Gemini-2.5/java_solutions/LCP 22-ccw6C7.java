class Solution {
    public int minFlips(char[][] grid) {
        int m = grid.length;
        if (m == 0) {
            return 0;
        }
        int n = grid[0].length;
        if (n == 0) {
            return 0;
        }

        int flipsForPattern0 = 0; // Count flips for pattern starting with '0' at (0,0)
        int flipsForPattern1 = 0; // Count flips for pattern starting with '1' at (0,0)

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                // Determine the expected character based on (i+j) parity
                // For pattern starting with '0':
                // (i+j) % 2 == 0 -> expected '0'
                // (i+j) % 2 == 1 -> expected '1'
                char expectedChar0 = ((i + j) % 2 == 0) ? '0' : '1';
                if (grid[i][j] != expectedChar0) {
                    flipsForPattern0++;
                }

                // For pattern starting with '1':
                // (i+j) % 2 == 0 -> expected '1'
                // (i+j) % 2 == 1 -> expected '0'
                char expectedChar1 = ((i + j) % 2 == 0) ? '1' : '0';
                if (grid[i][j] != expectedChar1) {
                    flipsForPattern1++;
                }
            }
        }

        return Math.min(flipsForPattern0, flipsForPattern1);
    }
}