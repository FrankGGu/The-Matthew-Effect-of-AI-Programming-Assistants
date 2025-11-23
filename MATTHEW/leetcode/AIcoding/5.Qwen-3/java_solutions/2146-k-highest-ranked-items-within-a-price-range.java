public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> highestRankedKItemsOfGrid(int[][] grid, int priceLow, int priceHigh) {
        int rows = grid.length;
        int cols = grid[0].length;
        List<int[]> items = new ArrayList<>();

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] >= priceLow && grid[i][j] <= priceHigh) {
                    items.add(new int[]{i, j, grid[i][j]});
                }
            }
        }

        items.sort((a, b) -> {
            if (a[2] != b[2]) return a[2] - b[2];
            if (a[0] != b[0]) return a[0] - b[0];
            return a[1] - b[1];
        });

        List<List<Integer>> result = new ArrayList<>();
        for (int i = 0; i < Math.min(5, items.size()); i++) {
            List<Integer> item = new ArrayList<>();
            item.add(items.get(i)[0]);
            item.add(items.get(i)[1]);
            result.add(item);
        }

        return result;
    }
}
}