import java.util.*;

public class Solution {
    public int[] hitBricks(int[][] grid, int[][] hits) {
        int m = grid.length, n = grid[0].length;
        int[] res = new int[hits.length];
        int[][] temp = new int[m][n];

        for (int[] hit : hits) {
            temp[hit[0]][hit[1]] = 1;
        }

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1 && temp[i][j] == 0) {
                    temp[i][j] = 1;
                }
            }
        }

        UnionFind uf = new UnionFind(m * n + 1);
        for (int i = 0; i < n; i++) {
            if (temp[0][i] == 1) {
                uf.union(0, i + 1);
            }
        }

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (temp[i][j] == 1) {
                    int index = i * n + j + 1;
                    if (i > 0 && temp[i - 1][j] == 1) {
                        uf.union(index, (i - 1) * n + j + 1);
                    }
                    if (j > 0 && temp[i][j - 1] == 1) {
                        uf.union(index, i * n + j);
                    }
                }
            }
        }

        for (int i = hits.length - 1; i >= 0; i--) {
            int x = hits[i][0], y = hits[i][1];
            if (grid[x][y] == 0) {
                continue;
            }
            int preCount = uf.getCount();
            temp[x][y] = 1;
            int index = x * n + y + 1;
            if (x == 0) {
                uf.union(0, index);
            }
            if (x > 0 && temp[x - 1][y] == 1) {
                uf.union(index, (x - 1) * n + y + 1);
            }
            if (y > 0 && temp[x][y - 1] == 1) {
                uf.union(index, x * n + y);
            }
            if (y < n - 1 && temp[x][y + 1] == 1) {
                uf.union(index, x * n + y + 2);
            }
            if (x < m - 1 && temp[x + 1][y] == 1) {
                uf.union(index, (x + 1) * n + y + 1);
            }
            int newCount = uf.getCount();
            res[i] = Math.max(0, newCount - preCount - 1);
        }

        return res;
    }

    class UnionFind {
        int[] parent;
        int[] size;
        int count;

        UnionFind(int n) {
            parent = new int[n];
            size = new int[n];
            Arrays.fill(size, 1);
            for (int i = 0; i < n; i++) {
                parent[i] = i;
            }
            count = 0;
        }

        int find(int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        }

        void union(int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX != rootY) {
                if (size[rootX] < size[rootY]) {
                    parent[rootX] = rootY;
                    size[rootY] += size[rootX];
                } else {
                    parent[rootY] = rootX;
                    size[rootX] += size[rootY];
                }
            }
        }

        int getCount() {
            int count = 0;
            for (int i = 1; i < parent.length; i++) {
                if (find(i) == 0) {
                    count++;
                }
            }
            return count;
        }
    }
}