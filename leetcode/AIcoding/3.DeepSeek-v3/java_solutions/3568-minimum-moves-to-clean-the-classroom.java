class Solution {
    private static final int[][] DIRS = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
    private int m, n;
    private int[][][][] memo;

    public int cleanRoom(Robot robot) {
        m = 1 << 8;
        n = 1 << 8;
        memo = new int[m][n][4][2];
        return dfs(robot, 0, 0, 0, 0);
    }

    private int dfs(Robot robot, int x, int y, int dir, int state) {
        if (memo[x][y][dir][state] != 0) {
            return memo[x][y][dir][state];
        }
        if (state == 1 && x == 0 && y == 0 && dir == 0) {
            return 0;
        }
        int res = Integer.MAX_VALUE;
        if (state == 0) {
            robot.clean();
            int nextState = 1;
            int next = dfs(robot, x, y, dir, nextState);
            if (next != Integer.MAX_VALUE) {
                res = Math.min(res, 1 + next);
            }
            robot.clean();
        } else {
            for (int i = 0; i < 4; i++) {
                int newDir = (dir + i) % 4;
                robot.turnRight();
                if (i == 3) {
                    continue;
                }
                int nx = x + DIRS[newDir][0];
                int ny = y + DIRS[newDir][1];
                if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                    if (robot.move()) {
                        int next = dfs(robot, nx, ny, newDir, state);
                        if (next != Integer.MAX_VALUE) {
                            res = Math.min(res, 1 + i + next);
                        }
                        robot.turnRight();
                        robot.turnRight();
                        robot.move();
                        robot.turnRight();
                        robot.turnRight();
                    }
                }
            }
        }
        memo[x][y][dir][state] = res == Integer.MAX_VALUE ? -1 : res;
        return memo[x][y][dir][state];
    }
}

interface Robot {
    boolean move();
    void turnLeft();
    void turnRight();
    void clean();
}