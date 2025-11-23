class Solution {
    private static final int[][] DIRECTIONS = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

    public int minimalSteps(String[] maze) {
        int m = maze.length;
        int n = maze[0].length();
        List<int[]> stones = new ArrayList<>();
        int sx = -1, sy = -1, tx = -1, ty = -1;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                char c = maze[i].charAt(j);
                if (c == 'S') {
                    sx = i;
                    sy = j;
                } else if (c == 'T') {
                    tx = i;
                    ty = j;
                } else if (c == 'O') {
                    stones.add(new int[]{i, j});
                }
            }
        }
        int stoneCount = stones.size();
        stones.add(0, new int[]{sx, sy});
        stones.add(new int[]{tx, ty});

        int[][] dist = new int[stoneCount + 2][stoneCount + 2];
        for (int i = 0; i < stoneCount + 2; i++) {
            Arrays.fill(dist[i], -1);
        }

        for (int i = 0; i < stoneCount + 2; i++) {
            for (int j = i + 1; j < stoneCount + 2; j++) {
                int d = bfs(maze, stones.get(i)[0], stones.get(i)[1], stones.get(j)[0], stones.get(j)[1]);
                dist[i][j] = d;
                dist[j][i] = d;
            }
        }

        for (int i = 0; i < stoneCount + 2; i++) {
            for (int j = 0; j < stoneCount + 2; j++) {
                if (dist[i][j] == -1) {
                    return -1;
                }
            }
        }

        if (stoneCount == 0) {
            return dist[0][stoneCount + 1];
        }

        int[][] dp = new int[1 << stoneCount][stoneCount];
        for (int i = 0; i < (1 << stoneCount); i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE);
        }

        for (int i = 0; i < stoneCount; i++) {
            dp[1 << i][i] = dist[0][i + 1];
        }

        for (int mask = 1; mask < (1 << stoneCount); mask++) {
            for (int i = 0; i < stoneCount; i++) {
                if ((mask & (1 << i)) != 0) {
                    for (int j = 0; j < stoneCount; j++) {
                        if (i != j && (mask & (1 << j)) == 0) {
                            if (dp[mask][i] != Integer.MAX_VALUE) {
                                dp[mask | (1 << j)][j] = Math.min(dp[mask | (1 << j)][j], dp[mask][i] + dist[i + 1][j + 1]);
                            }
                        }
                    }
                }
            }
        }

        int ans = Integer.MAX_VALUE;
        for (int i = 0; i < stoneCount; i++) {
            ans = Math.min(ans, dp[(1 << stoneCount) - 1][i] + dist[i + 1][stoneCount + 1]);
        }

        return ans == Integer.MAX_VALUE ? -1 : ans;
    }

    private int bfs(String[] maze, int sx, int sy, int tx, int ty) {
        int m = maze.length;
        int n = maze[0].length();
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{sx, sy, 0});
        boolean[][] visited = new boolean[m][n];
        visited[sx][sy] = true;

        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            int x = curr[0];
            int y = curr[1];
            int steps = curr[2];

            if (x == tx && y == ty) {
                return steps;
            }

            for (int[] dir : DIRECTIONS) {
                int nx = x + dir[0];
                int ny = y + dir[1];

                if (nx >= 0 && nx < m && ny >= 0 && ny < n && maze[nx].charAt(ny) != '#' && !visited[nx][ny]) {
                    visited[nx][ny] = true;
                    queue.offer(new int[]{nx, ny, steps + 1});
                }
            }
        }

        return -1;
    }
}