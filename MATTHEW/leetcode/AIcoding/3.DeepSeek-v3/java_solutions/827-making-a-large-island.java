class Solution {
    private int[][] directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

    public int largestIsland(int[][] grid) {
        if (grid == null || grid.length == 0) return 0;
        int n = grid.length;
        int max = 0;
        int islandId = 2;
        Map<Integer, Integer> map = new HashMap<>();

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    int size = dfs(grid, i, j, islandId);
                    map.put(islandId, size);
                    max = Math.max(max, size);
                    islandId++;
                }
            }
        }

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 0) {
                    Set<Integer> set = new HashSet<>();
                    for (int[] dir : directions) {
                        int x = i + dir[0];
                        int y = j + dir[1];
                        if (x >= 0 && x < n && y >= 0 && y < n && grid[x][y] != 0) {
                            set.add(grid[x][y]);
                        }
                    }
                    int sum = 1;
                    for (int id : set) {
                        sum += map.get(id);
                    }
                    max = Math.max(max, sum);
                }
            }
        }

        return max;
    }

    private int dfs(int[][] grid, int i, int j, int islandId) {
        if (i < 0 || i >= grid.length || j < 0 || j >= grid[0].length || grid[i][j] != 1) {
            return 0;
        }
        grid[i][j] = islandId;
        int count = 1;
        for (int[] dir : directions) {
            count += dfs(grid, i + dir[0], j + dir[1], islandId);
        }
        return count;
    }
}