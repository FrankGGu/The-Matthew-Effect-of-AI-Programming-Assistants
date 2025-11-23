import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

class Solution {
    private int[][] grid;
    private int n;
    private Map<Integer, Integer> islandSizes;
    private int[] dr = {-1, 1, 0, 0};
    private int[] dc = {0, 0, -1, 1};

    public int largestIsland(int[][] grid) {
        this.grid = grid;
        n = grid.length;
        islandSizes = new HashMap<>();
        int islandId = 2; // Start from 2 to distinguish from 0 (water) and 1 (unvisited land)
        int maxOverallIslandSize = 0;

        // Step 1: Identify and size existing islands using DFS
        for (int r = 0; r < n; r++) {
            for (int c = 0; c < n; c++) {
                if (grid[r][c] == 1) {
                    int size = dfs(r, c, islandId);
                    islandSizes.put(islandId, size);
                    maxOverallIslandSize = Math.max(maxOverallIslandSize, size);
                    islandId++;
                }
            }
        }

        // If no '0's were found, it means the grid was all '1's.
        // In this case, maxOverallIslandSize already holds n*n.
        // Or if the grid was all '0's, maxOverallIslandSize is 0, and the next loop will handle it.
        boolean hasZero = false;

        // Step 2: Iterate through '0' cells and calculate potential new island sizes
        for (int r = 0; r < n; r++) {
            for (int c = 0; c < n; c++) {
                if (grid[r][c] == 0) {
                    hasZero = true;
                    int currentPotentialSize = 1; // For the '0' itself
                    Set<Integer> adjacentIslandIds = new HashSet<>();

                    // Check 4 neighbors
                    for (int k = 0; k < 4; k++) {
                        int nr = r + dr[k];
                        int nc = c + dc[k];

                        // If neighbor is in bounds and is part of an identified island (ID > 1)
                        if (isValid(nr, nc) && grid[nr][nc] > 1) {
                            adjacentIslandIds.add(grid[nr][nc]);
                        }
                    }

                    // Sum the sizes of unique adjacent islands
                    for (int id : adjacentIslandIds) {
                        currentPotentialSize += islandSizes.get(id);
                    }
                    maxOverallIslandSize = Math.max(maxOverallIslandSize, currentPotentialSize);
                }
            }
        }

        // If no '0's were found in the grid, it means the grid was entirely '1's.
        // In this case, maxOverallIslandSize would have been set to n*n in the first step.
        // This check ensures that if the grid is all 1s, we return n*n.
        if (!hasZero) {
            return n * n;
        }

        return maxOverallIslandSize;
    }

    private int dfs(int r, int c, int currentIslandId) {
        if (!isValid(r, c) || grid[r][c] != 1) {
            return 0;
        }

        grid[r][c] = currentIslandId; // Mark as visited and assign island ID
        int count = 1; // Count the current cell

        // Recursively call DFS for 4 neighbors
        for (int k = 0; k < 4; k++) {
            count += dfs(r + dr[k], c + dc[k], currentIslandId);
        }
        return count;
    }

    private boolean isValid(int r, int c) {
        return r >= 0 && r < n && c >= 0 && c < n;
    }
}