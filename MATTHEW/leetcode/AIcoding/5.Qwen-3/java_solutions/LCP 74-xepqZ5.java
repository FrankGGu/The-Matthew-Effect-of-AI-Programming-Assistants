public class Solution {

import java.util.*;

public class Solution {
    public int strongestFriendshipField(int[][] grid) {
        int n = grid.length;
        int max = 0;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    int count = 0;
                    for (int dx = -1; dx <= 1; dx++) {
                        for (int dy = -1; dy <= 1; dy++) {
                            if (dx == 0 && dy == 0) continue;
                            int x = i + dx;
                            int y = j + dy;
                            if (x >= 0 && x < n && y >= 0 && y < n && grid[x][y] == 1) {
                                count++;
                            }
                        }
                    }
                    max = Math.max(max, count);
                }
            }
        }
        return max;
    }
}
}