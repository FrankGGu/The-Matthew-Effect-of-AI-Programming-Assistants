public class Solution {

import java.util.*;

public class Solution {
    public int[] hitBricks(int[][] grid, int[][] hits) {
        int m = grid.length;
        int n = grid[0].length;
        int[] result = new int[hits.length];

        for (int i = 0; i < hits.length; i++) {
            int x = hits[i][0];
            int y = hits[i][1];
            if (grid[x][y] == 1) {
                grid[x][y] = 0;
            }
        }

        int[][] directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        UnionFind uf = new UnionFind(m * n);

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    int index = i * n + j;
                    if (i > 0 && grid[i - 1][j] == 1) {
                        uf.union(index, (i - 1) * n + j);
                    }
                    if (j > 0 && grid[i][j - 1] == 1) {
                        uf.union(index, i * n + (j - 1));
                    }
                }
            }
        }

        for (int i = hits.length - 1; i >= 0; i--) {
            int x = hits[i][0];
            int y = hits[i][1];
            if (grid[x][y] == 0) {
                result[i] = 0;
                continue;
            }
            grid[x][y] = 1;
            int count = 0;
            for (int[] dir : directions) {
                int nx = x + dir[0];
                int ny = y + dir[1];
                if (nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] == 1) {
                    int neighborIndex = nx * n + ny;
                    int currentIndex = x * n + y;
                    if (uf.find(neighborIndex) == uf.find(currentIndex)) {
                        count++;
                    }
                }
            }
            result[i] = count;
        }

        return result;
    }

    private class UnionFind {
        int[] parent;

        public UnionFind(int size) {
            parent = new int[size];
            for (int i = 0; i < size; i++) {
                parent[i] = i;
            }
        }

        public int find(int x) {
            while (parent[x] != x) {
                parent[x] = parent[parent[x]];
                x = parent[x];
            }
            return x;
        }

        public void union(int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX != rootY) {
                parent[rootX] = rootY;
            }
        }
    }
}
}