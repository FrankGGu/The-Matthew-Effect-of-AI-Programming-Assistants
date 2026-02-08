class Solution {
    public int largestIsland(int[][] grid) {
        int n = grid.length;
        int m = grid[0].length;
        int[] parent = new int[n * m];
        int[] size = new int[n * m];
        for (int i = 0; i < n * m; i++) {
            parent[i] = i;
            size[i] = 1;
        }

        int[][] directions = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (grid[i][j] == 1) {
                    for (int[] dir : directions) {
                        int newI = i + dir[0];
                        int newJ = j + dir[1];
                        if (newI >= 0 && newI < n && newJ >= 0 && newJ < m && grid[newI][newJ] == 1) {
                            union(grid, parent, size, i, j, newI, newJ);
                        }
                    }
                }
            }
        }

        int maxArea = 0;
        for (int i = 0; i < n * m; i++) {
            maxArea = Math.max(maxArea, size[find(parent, i)]);
        }

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (grid[i][j] == 0) {
                    int area = 1;
                    HashSet<Integer> visited = new HashSet<>();
                    for (int[] dir : directions) {
                        int newI = i + dir[0];
                        int newJ = j + dir[1];
                        if (newI >= 0 && newI < n && newJ >= 0 && newJ < m && grid[newI][newJ] == 1) {
                            int root = find(parent, newI * m + newJ);
                            if (!visited.contains(root)) {
                                area += size[root];
                                visited.add(root);
                            }
                        }
                    }
                    maxArea = Math.max(maxArea, area);
                }
            }
        }

        return maxArea;
    }

    private void union(int[][] grid, int[] parent, int[] size, int i, int j, int newI, int newJ) {
        int rootI = find(parent, i * grid[0].length + j);
        int rootJ = find(parent, newI * grid[0].length + newJ);
        if (rootI != rootJ) {
            parent[rootJ] = rootI;
            size[rootI] += size[rootJ];
        }
    }

    private int find(int[] parent, int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent, parent[i]);
    }
}