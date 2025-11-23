import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

class Solution {
    private int[][] heights;
    private int rows, cols;

    public List<List<Integer>> pacificAtlantic(int[][] heights) {
        this.heights = heights;
        this.rows = heights.length;
        this.cols = heights[0].length;

        Set<List<Integer>> pacificReachable = new HashSet<>();
        Set<List<Integer>> atlanticReachable = new HashSet<>();

        for (int i = 0; i < rows; i++) {
            dfs(i, 0, pacificReachable, Integer.MIN_VALUE);
            dfs(i, cols - 1, atlanticReachable, Integer.MIN_VALUE);
        }

        for (int j = 0; j < cols; j++) {
            dfs(0, j, pacificReachable, Integer.MIN_VALUE);
            dfs(rows - 1, j, atlanticReachable, Integer.MIN_VALUE);
        }

        List<List<Integer>> result = new ArrayList<>();
        for (List<Integer> cell : pacificReachable) {
            if (atlanticReachable.contains(cell)) {
                result.add(cell);
            }
        }

        return result;
    }

    private void dfs(int row, int col, Set<List<Integer>> reachable, int prevHeight) {
        if (row < 0 || row >= rows || col < 0 || col >= cols || reachable.contains(List.of(row, col)) || heights[row][col] < prevHeight) {
            return;
        }

        reachable.add(List.of(row, col));

        dfs(row + 1, col, reachable, heights[row][col]);
        dfs(row - 1, col, reachable, heights[row][col]);
        dfs(row, col + 1, reachable, heights[row][col]);
        dfs(row, col - 1, reachable, heights[row][col]);
    }
}