public class Solution {

import java.util.*;

public class Solution {
    public long maximumValueSum(int[][] board) {
        int n = board.length;
        int m = board[0].length;
        long maxSum = 0;
        boolean[] rowUsed = new boolean[n];
        boolean[] colUsed = new boolean[m];
        int[] rowMax = new int[n];
        int[] colMax = new int[m];

        for (int i = 0; i < n; i++) {
            rowMax[i] = Arrays.stream(board[i]).max().getAsInt();
        }

        for (int j = 0; j < m; j++) {
            int max = Integer.MIN_VALUE;
            for (int i = 0; i < n; i++) {
                max = Math.max(max, board[i][j]);
            }
            colMax[j] = max;
        }

        List<int[]> candidates = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (board[i][j] == rowMax[i] && board[i][j] == colMax[j]) {
                    candidates.add(new int[]{i, j});
                }
            }
        }

        for (int k = 0; k < 3; k++) {
            long best = Long.MIN_VALUE;
            int bestI = -1, bestJ = -1;
            for (int[] candidate : candidates) {
                int i = candidate[0];
                int j = candidate[1];
                if (!rowUsed[i] && !colUsed[j]) {
                    long current = board[i][j];
                    if (current > best) {
                        best = current;
                        bestI = i;
                        bestJ = j;
                    }
                }
            }
            if (best == Long.MIN_VALUE) {
                return -1;
            }
            maxSum += best;
            rowUsed[bestI] = true;
            colUsed[bestJ] = true;
        }

        return maxSum;
    }
}
}