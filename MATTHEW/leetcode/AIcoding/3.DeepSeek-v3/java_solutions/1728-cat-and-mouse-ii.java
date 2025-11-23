class Solution {
    private static final int[][] dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
    private int[][][][][] memo;
    private int[][] grid;
    private int m;
    private int n;
    private int cj;
    private int mj;

    public boolean canMouseWin(String[] grid, int catJump, int mouseJump) {
        this.m = grid.length;
        this.n = grid[0].length();
        this.cj = catJump;
        this.mj = mouseJump;
        this.grid = new int[m][n];
        int[] catStart = new int[2];
        int[] mouseStart = new int[2];
        int[] food = new int[2];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                char c = grid[i].charAt(j);
                if (c == 'C') {
                    catStart[0] = i;
                    catStart[1] = j;
                    this.grid[i][j] = 0;
                } else if (c == 'M') {
                    mouseStart[0] = i;
                    mouseStart[1] = j;
                    this.grid[i][j] = 0;
                } else if (c == 'F') {
                    food[0] = i;
                    food[1] = j;
                    this.grid[i][j] = 0;
                } else if (c == '#') {
                    this.grid[i][j] = 1;
                } else {
                    this.grid[i][j] = 0;
                }
            }
        }
        memo = new int[m][n][m][n][200];
        return dfs(catStart[0], catStart[1], mouseStart[0], mouseStart[1], 0, food);
    }

    private boolean dfs(int cx, int cy, int mx, int my, int turn, int[] food) {
        if (turn >= 200) {
            return false;
        }
        if (memo[cx][cy][mx][my][turn] != 0) {
            return memo[cx][cy][mx][my][turn] == 1;
        }
        if (cx == food[0] && cy == food[1]) {
            memo[cx][cy][mx][my][turn] = -1;
            return false;
        }
        if (mx == food[0] && my == food[1]) {
            memo[cx][cy][mx][my][turn] = 1;
            return true;
        }
        if (cx == mx && cy == my) {
            memo[cx][cy][mx][my][turn] = -1;
            return false;
        }
        boolean res;
        if (turn % 2 == 0) {
            res = false;
            for (int[] dir : dirs) {
                for (int j = 0; j <= mj; j++) {
                    int nx = mx + dir[0] * j;
                    int ny = my + dir[1] * j;
                    if (nx < 0 || nx >= m || ny < 0 || ny >= n || grid[nx][ny] == 1) {
                        break;
                    }
                    if (dfs(cx, cy, nx, ny, turn + 1, food)) {
                        res = true;
                        break;
                    }
                }
                if (res) {
                    break;
                }
            }
        } else {
            res = true;
            for (int[] dir : dirs) {
                for (int j = 0; j <= cj; j++) {
                    int nx = cx + dir[0] * j;
                    int ny = cy + dir[1] * j;
                    if (nx < 0 || nx >= m || ny < 0 || ny >= n || grid[nx][ny] == 1) {
                        break;
                    }
                    if (!dfs(nx, ny, mx, my, turn + 1, food)) {
                        res = false;
                        break;
                    }
                }
                if (!res) {
                    break;
                }
            }
        }
        memo[cx][cy][mx][my][turn] = res ? 1 : -1;
        return res;
    }
}