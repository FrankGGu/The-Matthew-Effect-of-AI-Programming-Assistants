import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.TreeSet;

class Solution {
    public int[] getBiggestThree(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        // Use a TreeSet to store distinct rhombus sums in descending order.
        // It automatically handles uniqueness and sorting.
        TreeSet<Integer> rhombusSums = new TreeSet<>(Collections.reverseOrder());

        for (int r = 0; r < m; r++) {
            for (int c = 0; c < n; c++) {
                // Case s = 0: A rhombus of size 0 is just a single cell.
                rhombusSums.add(grid[r][c]);

                // Case s > 0: Iterate through possible sizes 's' for a rhombus centered at (r, c).
                // The size 's' determines the distance from the center to its four vertices.
                // Vertices are: (r-s, c), (r+s, c), (r, c-s), (r, c+s).
                for (int s = 1; ; s++) {
                    // Check if all four vertices are within grid boundaries.
                    if (r - s < 0 || r + s >= m || c - s < 0 || c + s >= n) {
                        break; // Rhombus of this size or larger is out of bounds.
                    }

                    long currentSum = 0; // Use long for intermediate sum to prevent potential overflow.

                    // Calculate the sum of all cells on the perimeter.
                    // The perimeter consists of four segments.
                    // When summing these four segments directly, the four corner vertices
                    // (r-s, c), (r+s, c), (r, c-s), (r, c+s) are each counted twice.
                    // All other points on the perimeter are counted exactly once.
                    for (int k = 0; k <= s; k++) {
                        // Top-left segment: from (r-s, c) to (r, c-s)
                        currentSum += grid[r - s + k][c - k];
                        // Top-right segment: from (r-s, c) to (r, c+s)
                        currentSum += grid[r - s + k][c + k];
                        // Bottom-left segment: from (r, c-s) to (r+s, c)
                        currentSum += grid[r + k][c - s + k];
                        // Bottom-right segment: from (r, c+s) to (r+s, c)
                        currentSum += grid[r + k][c + s - k];
                    }

                    // Subtract the values of the four corner vertices once,
                    // as they were double-counted in the loop above.
                    currentSum -= grid[r - s][c]; // Top vertex
                    currentSum -= grid[r + s][c]; // Bottom vertex
                    currentSum -= grid[r][c - s]; // Left vertex
                    currentSum -= grid[r][c + s]; // Right vertex

                    rhombusSums.add((int) currentSum);
                }
            }
        }

        // Extract the top 3 distinct sums from the TreeSet.
        List<Integer> resultList = new ArrayList<>();
        for (int sum : rhombusSums) {
            resultList.add(sum);
            if (resultList.size() == 3) {
                break; // We only need the biggest three.
            }
        }

        // Convert the list of sums to an int array.
        int[] result = new int[resultList.size()];
        for (int i = 0; i < resultList.size(); i++) {
            result[i] = resultList.get(i);
        }

        return result;
    }
}