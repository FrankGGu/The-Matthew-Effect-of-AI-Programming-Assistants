class DSU {
    int[] parent;
    int[] size; // Stores the size of the component, including the parent itself.

    public DSU(int n) {
        parent = new int[n];
        size = new int[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
            size[i] = 1;
        }
    }

    public int find(int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent[i]);
    }

    public void union(int i, int j) {
        int rootI = find(i);
        int rootJ = find(j);
        if (rootI != rootJ) {
            if (size[rootI] < size[rootJ]) {
                int temp = rootI;
                rootI = rootJ;
                rootJ = temp;
            }
            parent[rootJ] = rootI;
            size[rootI] += size[rootJ];
        }
    }

    public int getSize(int i) {
        return size[find(i)];
    }
}

class Solution {
    public int[] hitBricks(int[][] grid, int[][] hits) {
        int R = grid.length;
        int C = grid[0].length;

        int[][] currentGridState = new int[R][C];
        for (int i = 0; i < R; i++) {
            for (int j = 0; j < C; j++) {
                currentGridState[i][j] = grid[i][j];
            }
        }

        for (int[] hit : hits) {
            int r = hit[0];
            int c = hit[1];
            if (currentGridState[r][c] == 1) {
                currentGridState[r][c] = 0;
            }
        }

        DSU dsu = new DSU(R * C + 1);
        int virtualTop = R * C;

        int[] dr = {-1, 1, 0, 0};
        int[] dc = {0, 0, -1, 1};

        for (int i = 0; i < R; i++) {
            for (int j = 0; j < C; j++) {
                if (currentGridState[i][j] == 1) {
                    if (i == 0) {
                        dsu.union(i * C + j, virtualTop);
                    }
                    for (int k = 0; k < 4; k++) {
                        int ni = i + dr[k];
                        int nj = j + dc[k];
                        if (ni >= 0 && ni < R && nj >= 0 && nj < C && currentGridState[ni][nj] == 1) {
                            dsu.union(i * C + j, ni * C + nj);
                        }
                    }
                }
            }
        }

        int[] ans = new int[hits.length];
        for (int k = hits.length - 1; k >= 0; k--) {
            int r = hits[k][0];
            int c = hits[k][1];

            if (grid[r][c] == 0) {
                ans[k] = 0;
                continue;
            }

            int prevConnectedToTop = dsu.getSize(virtualTop);

            currentGridState[r][c] = 1;

            if (r == 0) {
                dsu.union(r * C + c, virtualTop);
            }
            for (int i = 0; i < 4; i++) {
                int nr = r + dr[i];
                int nc = c + dc[i];
                if (nr >= 0 && nr < R && nc >= 0 && nc < C && currentGridState[nr][nc] == 1) {
                    dsu.union(r * C + c, nr * C + nc);
                }
            }

            int currConnectedToTop = dsu.getSize(virtualTop);

            ans[k] = Math.max(0, currConnectedToTop - prevConnectedToTop - 1);
        }

        return ans;
    }
}