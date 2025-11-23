import java.util.*;

public class Solution {
    public List<List<Integer>> highestRankedKItems(int[][] grid, int[] pricing, int k) {
        List<List<Integer>> result = new ArrayList<>();
        int rows = grid.length, cols = grid[0].length;
        List<int[]> items = new ArrayList<>();

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] >= pricing[0] && grid[i][j] <= pricing[1]) {
                    items.add(new int[]{grid[i][j], i, j});
                }
            }
        }

        items.sort((a, b) -> {
            if (a[0] != b[0]) return Integer.compare(b[0], a[0]);
            if (a[1] != b[1]) return Integer.compare(a[1], b[1]);
            return Integer.compare(a[2], b[2]);
        });

        for (int i = 0; i < Math.min(k, items.size()); i++) {
            result.add(Arrays.asList(items.get(i)[1], items.get(i)[2]));
        }

        return result;
    }
}