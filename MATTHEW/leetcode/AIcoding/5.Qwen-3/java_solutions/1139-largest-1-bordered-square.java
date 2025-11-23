public class Solution {
    public int largest1BorderedSquare(int[][] grid) {
        int n = grid.length;
        int m = grid[0].length;
        int max = 0;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (grid[i][j] == 1) {
                    int side = 1;
                    while (i + side < n && j + side < m) {
                        if (grid[i][j + side] == 1 && grid[i + side][j] == 1) {
                            boolean valid = true;
                            for (int k = 1; k < side; k++) {
                                if (grid[i][j + k] != 1 || grid[i + k][j] != 1 || grid[i + side][j + k] != 1 || grid[i + k][j + side] != 1) {
                                    valid = false;
                                    break;
                                }
                            }
                            if (valid) {
                                side++;
                            } else {
                                break;
                            }
                        } else {
                            break;
                        }
                    }
                    max = Math.max(max, side);
                }
            }
        }
        return max * max;
    }
}