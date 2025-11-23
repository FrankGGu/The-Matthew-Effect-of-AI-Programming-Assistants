public class Solution {

import java.util.*;

public class Solution {
    public int[][] indexPairs(int[][] words, int k) {
        int m = words.length;
        int n = words[0].length;
        int[][] result = new int[m * n][2];
        int index = 0;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int minDiff = Integer.MAX_VALUE;
                int minRow = -1;
                int minCol = -1;

                for (int x = Math.max(0, i - k + 1); x <= Math.min(m - 1, i + k - 1); x++) {
                    for (int y = Math.max(0, j - k + 1); y <= Math.min(n - 1, j + k - 1); y++) {
                        if (x == i && y == j) continue;
                        int diff = Math.abs(words[i][j] - words[x][y]);
                        if (diff < minDiff || (diff == minDiff && (x < minRow || (x == minRow && y < minCol)))) {
                            minDiff = diff;
                            minRow = x;
                            minCol = y;
                        }
                    }
                }

                if (minRow != -1) {
                    result[index][0] = i;
                    result[index][1] = j;
                    index++;
                }
            }
        }

        int[][] finalResult = new int[index][2];
        for (int i = 0; i < index; i++) {
            finalResult[i][0] = result[i][0];
            finalResult[i][1] = result[i][1];
        }

        return finalResult;
    }
}
}