public class Solution {
    public int containVirus(int[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;
        int totalCost = 0;

        while (true) {
            int[][] visited = new int[rows][cols];
            int maxRegion = 0;
            int[] bestRegion = new int[2];
            int[][] regions = new int[rows][cols];
            int regionId = 1;
            int[] boundary = new int[1];

            for (int i = 0; i < rows; i++) {
                for (int j = 0; j < cols; j++) {
                    if (grid[i][j] == 1 && visited[i][j] == 0) {
                        int[] size = new int[1];
                        int[] boundarySize = new int[1];
                        dfs(grid, visited, i, j, regionId, size, boundarySize);
                        if (size[0] > maxRegion) {
                            maxRegion = size[0];
                            bestRegion[0] = i;
                            bestRegion[1] = j;
                            boundary[0] = boundarySize[0];
                        }
                        regionId++;
                    }
                }
            }

            if (maxRegion == 0) break;

            totalCost += boundary[0];

            for (int i = 0; i < rows; i++) {
                for (int j = 0; j < cols; j++) {
                    if (regions[i][j] == 1) {
                        grid[i][j] = 0;
                    }
                }
            }
        }

        return totalCost;
    }

    private void dfs(int[][] grid, int[][] visited, int i, int j, int regionId, int[] size, int[] boundary) {
        if (i < 0 || i >= grid.length || j < 0 || j >= grid[0].length || grid[i][j] != 1 || visited[i][j] == 1) {
            return;
        }

        visited[i][j] = 1;
        regions[i][j] = regionId;
        size[0]++;

        int[][] directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        for (int[] dir : directions) {
            int ni = i + dir[0];
            int nj = j + dir[1];
            if (ni < 0 || ni >= grid.length || nj < 0 || nj >= grid[0].length || grid[ni][nj] != 1) {
                boundary[0]++;
            } else {
                dfs(grid, visited, ni, nj, regionId, size, boundary);
            }
        }
    }
}