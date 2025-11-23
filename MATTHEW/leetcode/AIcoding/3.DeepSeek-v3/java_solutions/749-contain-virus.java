class Solution {
    private int[][] grid;
    private int rows, cols;
    private static final int[][] dirs = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

    public int containVirus(int[][] grid) {
        this.grid = grid;
        this.rows = grid.length;
        this.cols = grid[0].length;
        int result = 0;

        while (true) {
            List<Set<Integer>> regions = new ArrayList<>();
            List<Set<Integer>> frontiers = new ArrayList<>();
            List<Integer> perimeters = new ArrayList<>();
            boolean[][] visited = new boolean[rows][cols];

            for (int i = 0; i < rows; ++i) {
                for (int j = 0; j < cols; ++j) {
                    if (grid[i][j] == 1 && !visited[i][j]) {
                        regions.add(new HashSet<>());
                        frontiers.add(new HashSet<>());
                        perimeters.add(0);
                        dfs(i, j, visited, regions.get(regions.size() - 1), 
                            frontiers.get(frontiers.size() - 1), perimeters.get(perimeters.size() - 1));
                    }
                }
            }

            if (regions.isEmpty()) break;

            int maxIndex = 0;
            for (int i = 0; i < frontiers.size(); ++i) {
                if (frontiers.get(i).size() > frontiers.get(maxIndex).size()) {
                    maxIndex = i;
                }
            }

            result += perimeters.get(maxIndex);

            for (int i = 0; i < regions.size(); ++i) {
                if (i == maxIndex) {
                    for (int cell : regions.get(i)) {
                        int r = cell / cols, c = cell % cols;
                        grid[r][c] = -1;
                    }
                } else {
                    for (int cell : regions.get(i)) {
                        int r = cell / cols, c = cell % cols;
                        for (int[] dir : dirs) {
                            int nr = r + dir[0], nc = c + dir[1];
                            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && grid[nr][nc] == 0) {
                                grid[nr][nc] = 1;
                            }
                        }
                    }
                }
            }
        }

        return result;
    }

    private void dfs(int r, int c, boolean[][] visited, Set<Integer> region, Set<Integer> frontier, int perimeter) {
        if (r < 0 || r >= rows || c < 0 || c >= cols || visited[r][c] || grid[r][c] != 1) {
            return;
        }
        visited[r][c] = true;
        region.add(r * cols + c);
        for (int[] dir : dirs) {
            int nr = r + dir[0], nc = c + dir[1];
            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols) {
                if (grid[nr][nc] == 0) {
                    frontier.add(nr * cols + nc);
                    perimeter++;
                } else if (grid[nr][nc] == 1) {
                    dfs(nr, nc, visited, region, frontier, perimeter);
                }
            }
        }
    }
}