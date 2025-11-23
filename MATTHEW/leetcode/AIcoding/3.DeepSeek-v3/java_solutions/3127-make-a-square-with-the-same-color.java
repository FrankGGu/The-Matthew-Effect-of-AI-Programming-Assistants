class Solution {
    public boolean canMakeSquare(char[][] grid) {
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 2; j++) {
                int countB = 0, countW = 0;
                if (grid[i][j] == 'B') countB++;
                else countW++;
                if (grid[i][j + 1] == 'B') countB++;
                else countW++;
                if (grid[i + 1][j] == 'B') countB++;
                else countW++;
                if (grid[i + 1][j + 1] == 'B') countB++;
                else countW++;
                if (countB >= 3 || countW >= 3) {
                    return true;
                }
            }
        }
        return false;
    }
}