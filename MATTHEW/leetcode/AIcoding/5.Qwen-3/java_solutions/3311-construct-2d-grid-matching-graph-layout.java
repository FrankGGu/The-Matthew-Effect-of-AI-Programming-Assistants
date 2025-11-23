public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> construct2DGrid(List<Integer> grid, int m, int n) {
        List<List<Integer>> result = new ArrayList<>();
        for (int i = 0; i < m; i++) {
            List<Integer> row = new ArrayList<>();
            for (int j = 0; j < n; j++) {
                row.add(grid.get(i * n + j));
            }
            result.add(row);
        }
        return result;
    }
}
}