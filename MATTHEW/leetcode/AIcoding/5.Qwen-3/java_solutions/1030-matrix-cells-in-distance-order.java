public class Solution {

import java.util.*;

public class Solution {
    public int[][] allCellsDistOrder(int R, int C) {
        int[][] result = new int[R * C][2];
        int index = 0;
        for (int r = 0; r < R; r++) {
            for (int c = 0; c < C; c++) {
                result[index++] = new int[]{r, c};
            }
        }
        Arrays.sort(result, (a, b) -> Math.abs(a[0] - a[1]) - Math.abs(b[0] - b[1]));
        return result;
    }
}
}