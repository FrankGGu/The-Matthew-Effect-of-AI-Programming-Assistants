import java.util.ArrayList;
import java.util.List;

class Solution {
    public int[][] findFarmland(int[][] land) {
        int m = land.length;
        int n = land[0].length;
        List<int[]> result = new ArrayList<>();

        for (int r = 0; r < m; r++) {
            for (int c = 0; c < n; c++) {
                if (land[r][c] == 1) {
                    // Found the top-left corner of a farmland group
                    int r1 = r;
                    int c1 = c;

                    // Find the bottom-right corner (r2, c2)
                    // Expand horizontally to find the rightmost column (c2)
                    int c2 = c;
                    while (c2 < n && land[r][c2] == 1) {
                        c2++;
                    }
                    c2--; // Adjust back to the last valid column index

                    // Expand vertically to find the bottommost row (r2)
                    int r2 = r;
                    while (r2 < m && land[r2][c] == 1) {
                        r2++;
                    }
                    r2--; // Adjust back to the last valid row index

                    // Add the coordinates of the farmland group to the result
                    result.add(new int[]{r1, c1, r2, c2});

                    // Mark all cells in this farmland group as visited (0)
                    // to prevent re-processing
                    for (int i = r1; i <= r2; i++) {
                        for (int j = c1; j <= c2; j++) {
                            land[i][j] = 0;
                        }
                    }
                }
            }
        }

        // Convert List<int[]> to int[][]
        return result.toArray(new int[0][]);
    }
}