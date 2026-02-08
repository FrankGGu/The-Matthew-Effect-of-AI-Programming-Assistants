public class Solution {

import java.util.HashSet;
import java.util.Set;

public class Solution {
    public boolean isPossibleToChooseAllNumbers(int[][] grid) {
        int n = grid.length;
        for (int i = 0; i < n; i++) {
            Set<Integer> rowSet = new HashSet<>();
            Set<Integer> colSet = new HashSet<>();
            for (int j = 0; j < n; j++) {
                rowSet.add(grid[i][j]);
                colSet.add(grid[j][i]);
            }
            if (rowSet.size() != n || colSet.size() != n) {
                return false;
            }
        }
        return true;
    }
}
}