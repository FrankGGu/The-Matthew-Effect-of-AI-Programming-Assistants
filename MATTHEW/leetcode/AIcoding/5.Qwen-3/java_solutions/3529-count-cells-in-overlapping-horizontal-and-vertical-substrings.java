public class Solution {

import java.util.*;

public class Solution {
    public int countCells(int[] coordinates) {
        int x = coordinates[0];
        int y = coordinates[1];
        int[][] grid = new int[20][20];
        for (int i = 0; i < 20; i++) {
            for (int j = 0; j < 20; j++) {
                if (i == x || j == y) {
                    grid[i][j] = 1;
                }
            }
        }
        int count = 0;
        for (int i = 0; i < 20; i++) {
            for (int j = 0; j < 20; j++) {
                if (grid[i][j] == 1) {
                    count++;
                }
            }
        }
        return count;
    }
}
}