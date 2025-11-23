class Solution {
    public boolean canMakeSquare(char[][] grid) {
        for (int r = 0; r <= 1; r++) {
            for (int c = 0; c <= 1; c++) {
                int blackCount = 0;
                int whiteCount = 0;

                if (grid[r][c] == 'B') {
                    blackCount++;
                } else {
                    whiteCount++;
                }
                if (grid[r + 1][c] == 'B') {
                    blackCount++;
                } else {
                    whiteCount++;
                }
                if (grid[r][c + 1] == 'B') {
                    blackCount++;
                } else {
                    whiteCount++;
                }
                if (grid[r + 1][c + 1] == 'B') {
                    blackCount++;
                } else {
                    whiteCount++;
                }

                if (blackCount >= 3 || whiteCount >= 3) {
                    return true;
                }
            }
        }
        return false;
    }
}