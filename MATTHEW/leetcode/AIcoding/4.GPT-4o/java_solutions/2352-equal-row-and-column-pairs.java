import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int equalPairs(int[][] grid) {
        Map<String, Integer> rowCount = new HashMap<>();
        int n = grid.length;
        int count = 0;

        for (int i = 0; i < n; i++) {
            StringBuilder row = new StringBuilder();
            for (int j = 0; j < n; j++) {
                row.append(grid[i][j]).append(",");
            }
            rowCount.put(row.toString(), rowCount.getOrDefault(row.toString(), 0) + 1);
        }

        for (int j = 0; j < n; j++) {
            StringBuilder col = new StringBuilder();
            for (int i = 0; i < n; i++) {
                col.append(grid[i][j]).append(",");
            }
            count += rowCount.getOrDefault(col.toString(), 0);
        }

        return count;
    }
}