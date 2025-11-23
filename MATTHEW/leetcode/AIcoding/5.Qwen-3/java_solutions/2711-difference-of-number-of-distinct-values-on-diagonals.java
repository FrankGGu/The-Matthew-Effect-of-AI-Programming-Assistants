public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> differenceOfDistinctValues(List<List<Integer>> grid) {
        int m = grid.size();
        int n = grid.get(0).size();
        List<List<Integer>> result = new ArrayList<>();

        for (int i = 0; i < m; i++) {
            List<Integer> row = new ArrayList<>();
            for (int j = 0; j < n; j++) {
                Set<Integer> leftDiagonal = new HashSet<>();
                int x = i - 1, y = j - 1;
                while (x >= 0 && y >= 0) {
                    leftDiagonal.add(grid.get(x).get(y));
                    x--;
                    y--;
                }

                Set<Integer> rightDiagonal = new HashSet<>();
                x = i + 1;
                y = j + 1;
                while (x < m && y < n) {
                    rightDiagonal.add(grid.get(x).get(y));
                    x++;
                    y++;
                }

                int leftCount = leftDiagonal.size();
                int rightCount = rightDiagonal.size();
                row.add(Math.abs(leftCount - rightCount));
            }
            result.add(row);
        }

        return result;
    }
}
}