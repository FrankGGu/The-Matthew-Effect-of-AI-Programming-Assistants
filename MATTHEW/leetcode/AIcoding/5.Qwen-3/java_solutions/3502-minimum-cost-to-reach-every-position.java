public class Solution {

import java.util.*;

public class Solution {
    public int[] minCostToReachEveryPosition(int[] startPos, int[] homePos, int[] rowCosts, int[] colCosts) {
        int rows = rowCosts.length;
        int cols = colCosts.length;
        int[] result = new int[rows * cols];

        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) {
                int cost = 0;
                int currentR = startPos[0];
                int currentC = startPos[1];

                while (currentR != r) {
                    if (currentR < r) {
                        cost += rowCosts[currentR + 1];
                        currentR++;
                    } else {
                        cost += rowCosts[currentR - 1];
                        currentR--;
                    }
                }

                while (currentC != c) {
                    if (currentC < c) {
                        cost += colCosts[currentC + 1];
                        currentC++;
                    } else {
                        cost += colCosts[currentC - 1];
                        currentC--;
                    }
                }

                result[r * cols + c] = cost;
            }
        }

        return result;
    }
}
}