class Solution {
    public int largestIsland(int[][] grid) {
        int n = grid.length;
        int[][] directions = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
        Map<Integer, Integer> areaMap = new HashMap<>();
        int maxArea = 0;
        int islandId = 2;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    int area = dfs(grid, i, j, islandId);
                    areaMap.put(islandId, area);
                    maxArea = Math.max(maxArea, area);
                    islandId++;
                }
            }
        }

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 0) {
                    Set<Integer> seenIslands = new HashSet<>();
                    int totalArea = 1;
                    for (int[] direction : directions) {
                        int x = i + direction[0];
                        int y = j + direction[1];
                        if (x >= 0 && x < n && y >= 0 && y < n && grid[x][y] > 1) {
                            int island = grid[x][y];
                            if (!seenIslands.contains(island)) {
                                totalArea += areaMap.get(island);
                                seenIslands.add(island);
                            }
                        }
                    }
                    maxArea = Math.max(maxArea, totalArea);
                }
            }
        }

        return maxArea;
    }

    private int dfs(int[][] grid, int i, int j, int islandId) {
        if (i < 0 || i >= grid.length || j < 0 || j >= grid.length || grid[i][j] != 1) {
            return 0;
        }
        grid[i][j] = islandId;
        int area = 1;
        area += dfs(grid, i + 1, j, islandId);
        area += dfs(grid, i - 1, j, islandId);
        area += dfs(grid, i, j + 1, islandId);
        area += dfs(grid, i, j - 1, islandId);
        return area;
    }
}