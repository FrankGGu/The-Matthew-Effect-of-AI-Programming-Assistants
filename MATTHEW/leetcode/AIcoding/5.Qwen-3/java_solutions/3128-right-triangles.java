public class Solution {

import java.util.*;

public class Solution {
    public int numberOfRightTriangles(List<List<Integer>> grid) {
        int rows = grid.size();
        int cols = grid.get(0).size();
        Map<Integer, Integer> rowCounts = new HashMap<>();
        Map<Integer, Integer> colCounts = new HashMap<>();

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid.get(i).get(j) == 1) {
                    rowCounts.put(i, rowCounts.getOrDefault(i, 0) + 1);
                    colCounts.put(j, colCounts.getOrDefault(j, 0) + 1);
                }
            }
        }

        int count = 0;
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid.get(i).get(j) == 1) {
                    int row = rowCounts.get(i);
                    int col = colCounts.get(j);
                    count += (row - 1) * (col - 1);
                }
            }
        }

        return count;
    }
}
}