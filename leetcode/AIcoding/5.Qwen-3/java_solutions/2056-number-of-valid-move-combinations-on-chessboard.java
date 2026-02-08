public class Solution {

import java.util.*;

public class Solution {
    public int[] availableMoves(int[][] chessboard) {
        int[][] directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}, {-1, -1}, {-1, 1}, {1, -1}, {1, 1}};
        int n = chessboard.length;
        int[] result = new int[2];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (chessboard[i][j] == 1) {
                    int count = 0;
                    for (int[] dir : directions) {
                        int x = i + dir[0];
                        int y = j + dir[1];
                        while (x >= 0 && x < n && y >= 0 && y < n) {
                            if (chessboard[x][y] != 0) {
                                break;
                            }
                            count++;
                            x += dir[0];
                            y += dir[1];
                        }
                    }
                    result[0]++;
                    result[1] += count;
                }
            }
        }
        return result;
    }
}
}