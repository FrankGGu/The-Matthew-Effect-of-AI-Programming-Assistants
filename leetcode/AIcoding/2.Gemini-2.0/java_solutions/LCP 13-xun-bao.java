import java.util.*;

class Solution {
    public int minimalSteps(String[] maze) {
        int m = maze.length;
        int n = maze[0].length();
        List<int[]> stones = new ArrayList<>();
        int[] start = null;
        int[] target = null;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (maze[i].charAt(j) == 'S') {
                    start = new int[]{i, j};
                } else if (maze[i].charAt(j) == 'T') {
                    target = new int[]{i, j};
                } else if (maze[i].charAt(j) == 'M') {
                    stones.add(new int[]{i, j});
                }
            }
        }

        int stoneCount = stones.size();
        int[][] dist = new int[stoneCount + 2][stoneCount + 2];
        for (int i = 0; i < stoneCount + 2; i++) {
            Arrays.fill(dist[i], -1);
        }

        List<int[]> points = new ArrayList<>();
        points.add(start);
        points.addAll(stones);
        points.add(target);

        for (int i = 0; i < stoneCount + 2; i++) {
            for (int j = i + 1; j < stoneCount + 2; j++) {
                int d = bfs(maze, points.get(i), points.get(j));
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
            Arrays.fill(dp[i], -1);
        }

        for (int i = 0; i < stoneCount; i++) {
            dp[1 << i][i] = dist[0][i + 1];
        }

        for (int mask = 1; mask < (1 << stoneCount); mask++) {
            for (int i = 0; i < stoneCount; i++) {
                if ((mask & (1 << i)) != 0) {
                    for (int j = 0; j < stoneCount; j++) {
                        if ((mask & (1 << j)) == 0) {
                            if (dp[mask][i] != -1) {
                                int nextMask = mask | (1 << j);
                                int newDist = dp[mask][i] + dist[i + 1][j + 1];
                                if (dp[nextMask][j] == -1 || newDist < dp[nextMask][j]) {
                                    dp[nextMask][j] = newDist;
                                }
                            }
                        }
                    }
                }
            }
        }

        int ans = -1;
        int finalMask = (1 << stoneCount) - 1;
        for (int i = 0; i < stoneCount; i++) {
            if (dp[finalMask][i] != -1) {
                int totalDist = dp[finalMask][i] + dist[i + 1][stoneCount + 1];
                if (ans == -1 || totalDist < ans) {
                    ans = totalDist;
                }
            }
        }

        return ans;
    }

    private int bfs(String[] maze, int[] start, int[] target) {
        int m = maze.length;
        int n = maze[0].length();
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(start);
        boolean[][] visited = new boolean[m][n];
        visited[start[0]][start[1]] = true;
        int[][] directions = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};
        int steps = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int[] curr = queue.poll();
                if (curr[0] == target[0] && curr[1] == target[1]) {
                    return steps;
                }

                for (int[] dir : directions) {
                    int newRow = curr[0] + dir[0];
                    int newCol = curr[1] + dir[1];

                    if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n &&
                            maze[newRow].charAt(newCol) != '#' && !visited[newRow][newCol]) {
                        queue.offer(new int[]{newRow, newCol});
                        visited[newRow][newCol] = true;
                    }
                }
            }
            steps++;
        }

        return -1;
    }
}