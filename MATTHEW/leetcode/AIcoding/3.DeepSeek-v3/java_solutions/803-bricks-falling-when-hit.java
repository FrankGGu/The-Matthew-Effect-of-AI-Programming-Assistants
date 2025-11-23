class Solution {
    private static final int[][] dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
    private int[] parent;
    private int[] size;

    public int[] hitBricks(int[][] grid, int[][] hits) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] copy = new int[m][n];
        for (int i = 0; i < m; i++) {
            System.arraycopy(grid[i], 0, copy[i], 0, n);
        }
        for (int[] hit : hits) {
            copy[hit[0]][hit[1]] = 0;
        }
        int size = m * n;
        parent = new int[size + 1];
        this.size = new int[size + 1];
        for (int i = 0; i <= size; i++) {
            parent[i] = i;
            this.size[i] = 1;
        }
        for (int j = 0; j < n; j++) {
            if (copy[0][j] == 1) {
                union(j, size);
            }
        }
        for (int i = 1; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (copy[i][j] == 1) {
                    if (copy[i - 1][j] == 1) {
                        union(getIndex(i - 1, j, n), getIndex(i, j, n));
                    }
                    if (j > 0 && copy[i][j - 1] == 1) {
                        union(getIndex(i, j - 1, n), getIndex(i, j, n));
                    }
                }
            }
        }
        int hitsLen = hits.length;
        int[] res = new int[hitsLen];
        for (int i = hitsLen - 1; i >= 0; i--) {
            int x = hits[i][0];
            int y = hits[i][1];
            if (grid[x][y] == 0) {
                continue;
            }
            int origin = this.size[find(size)];
            if (x == 0) {
                union(y, size);
            }
            for (int[] dir : dirs) {
                int newX = x + dir[0];
                int newY = y + dir[1];
                if (newX >= 0 && newX < m && newY >= 0 && newY < n && copy[newX][newY] == 1) {
                    union(getIndex(x, y, n), getIndex(newX, newY, n));
                }
            }
            copy[x][y] = 1;
            int current = this.size[find(size)];
            res[i] = Math.max(0, current - origin - 1);
        }
        return res;
    }

    private int getIndex(int x, int y, int cols) {
        return x * cols + y;
    }

    private int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    private void union(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX == rootY) {
            return;
        }
        parent[rootX] = rootY;
        size[rootY] += size[rootX];
    }
}