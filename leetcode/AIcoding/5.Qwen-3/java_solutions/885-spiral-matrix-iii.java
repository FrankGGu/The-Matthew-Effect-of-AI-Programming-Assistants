public class Solution {
    public int[][] spiralMatrix(int rows, int cols, int rStart, int cStart) {
        int[][] result = new int[rows][cols];
        int[] dr = {0, 1, 0, -1};
        int[] dc = {1, 0, -1, 0};
        int step = 1;
        int dir = 0;
        int r = rStart;
        int c = cStart;
        int count = 0;
        while (count < rows * cols) {
            for (int i = 0; i < 2; i++) {
                for (int j = 0; j < step; j++) {
                    if (r >= 0 && r < rows && c >= 0 && c < cols) {
                        result[r][c] = count++;
                    }
                    r += dr[dir];
                    c += dc[dir];
                }
                dir = (dir + 1) % 4;
            }
            step++;
        }
        return result;
    }
}