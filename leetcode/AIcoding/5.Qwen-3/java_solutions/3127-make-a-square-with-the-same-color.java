public class Solution {

import java.util.*;

public class Solution {
    public boolean canMakeSquare(char[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;

        for (int i = 0; i <= rows - 2; i++) {
            for (int j = 0; j <= cols - 2; j++) {
                char c1 = grid[i][j];
                char c2 = grid[i][j + 1];
                char c3 = grid[i + 1][j];
                char c4 = grid[i + 1][j + 1];

                if (c1 == c2 && c1 == c3 && c1 == c4) {
                    return true;
                }

                if (c1 == c2 && c1 == c3 && c2 == c4) {
                    return true;
                }

                if (c1 == c2 && c1 == c4 && c3 == c4) {
                    return true;
                }

                if (c1 == c3 && c1 == c4 && c2 == c4) {
                    return true;
                }

                if (c2 == c3 && c2 == c4 && c1 == c4) {
                    return true;
                }

                if (c1 == c2 && c1 == c3) {
                    return true;
                }

                if (c1 == c2 && c1 == c4) {
                    return true;
                }

                if (c1 == c3 && c1 == c4) {
                    return true;
                }

                if (c2 == c3 && c2 == c4) {
                    return true;
                }
            }
        }

        return false;
    }
}
}