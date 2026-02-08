public class Solution {

import java.util.*;

public class Solution {
    public int maximumWhiteTiles(char[][] tiles, int carpetLen) {
        int n = tiles.length;
        int[][] sorted = new int[n][2];
        for (int i = 0; i < n; i++) {
            sorted[i][0] = tiles[i][0] - 'a';
            sorted[i][1] = tiles[i][1] - 'a';
        }
        Arrays.sort(sorted, (a, b) -> a[0] - b[0]);

        int max = 0;
        int j = 0;
        int covered = 0;
        for (int i = 0; i < n; i++) {
            int start = sorted[i][0];
            int end = sorted[i][1];
            while (j < n && sorted[j][0] <= start + carpetLen - 1) {
                if (sorted[j][1] <= start + carpetLen - 1) {
                    covered += sorted[j][1] - sorted[j][0] + 1;
                } else {
                    covered += start + carpetLen - 1 - sorted[j][0] + 1;
                }
                j++;
            }
            max = Math.max(max, covered);
            if (j > i) {
                covered -= sorted[i][1] - sorted[i][0] + 1;
            }
        }
        return max;
    }
}
}