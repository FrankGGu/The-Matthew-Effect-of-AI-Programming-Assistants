class Solution {
    public int[] hitBricks(int[][] grid, int[][] hits) {
        int rows = grid.length;
        int cols = grid[0].length;
        int hitLen = hits.length;
        int[] result = new int[hitLen];

        int[][] copyGrid = new int[rows][cols];
        for (int i = 0; i < rows; i++) {
            copyGrid[i] = grid[i].clone();
        }

        for (int[] hit : hits) {
            int row = hit[0];
            int col = hit[1];
            if (copyGrid[row][col] == 1) {
                copyGrid[row][col] = 0;
            } else {
                continue;
            }
        }

        int size = rows * cols;
        UnionFind uf = new UnionFind(size + 1);

        for (int j = 0; j < cols; j++) {
            if (copyGrid[0][j] == 1) {
                uf.union(j + 1, 0);
            }
        }

        int[][] directions = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

        for (int i = 1; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (copyGrid[i][j] == 1) {
                    for (int[] dir : directions) {
                        int newRow = i + dir[0];
                        int newCol = j + dir[1];
                        if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && copyGrid[newRow][newCol] == 1) {
                            uf.union(i * cols + j + 1, newRow * cols + newCol + 1);
                        }
                    }
                }
            }
        }

        for (int i = hitLen - 1; i >= 0; i--) {
            int row = hits[i][0];
            int col = hits[i][1];

            if (grid[row][col] == 0) {
                result[i] = 0;
                continue;
            }

            int prevSize = uf.getSize(0);
            copyGrid[row][col] = 1;

            if (row == 0) {
                uf.union(col + 1, 0);
            }

            for (int[] dir : directions) {
                int newRow = row + dir[0];
                int newCol = col + dir[1];
                if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && copyGrid[newRow][newCol] == 1) {
                    uf.union(row * cols + col + 1, newRow * cols + newCol + 1);
                }
            }

            int currSize = uf.getSize(0);
            result[i] = Math.max(0, currSize - prevSize - 1);
        }

        return result;
    }

    private static class UnionFind {
        private int[] parent;
        private int[] size;

        public UnionFind(int n) {
            parent = new int[n];
            size = new int[n];
            for (int i = 0; i < n; i++) {
                parent[i] = i;
                size[i] = 1;
            }
        }

        public int find(int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        }

        public void union(int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX != rootY) {
                parent[rootX] = rootY;
                size[rootY] += size[rootX];
            }
        }

        public int getSize(int x) {
            return size[find(x)];
        }
    }
}