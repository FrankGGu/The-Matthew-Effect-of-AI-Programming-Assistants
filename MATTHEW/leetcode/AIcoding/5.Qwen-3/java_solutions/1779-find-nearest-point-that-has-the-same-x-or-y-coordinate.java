public class Solution {

import java.util.*;

public class Solution {
    public int[] smallestDistanceBingo(int[][] grid, int x, int y) {
        int minDistance = Integer.MAX_VALUE;
        int[] result = new int[]{-1, -1};

        for (int i = 0; i < grid.length; i++) {
            for (int j = 0; j < grid[0].length; j++) {
                if (grid[i][j] == 0) {
                    continue;
                }
                if (i == x || j == y) {
                    int distance = Math.abs(i - x) + Math.abs(j - y);
                    if (distance < minDistance) {
                        minDistance = distance;
                        result[0] = i;
                        result[1] = j;
                    } else if (distance == minDistance) {
                        if (i < result[0] || (i == result[0] && j < result[1])) {
                            result[0] = i;
                            result[1] = j;
                        }
                    }
                }
            }
        }

        return result;
    }
}
}