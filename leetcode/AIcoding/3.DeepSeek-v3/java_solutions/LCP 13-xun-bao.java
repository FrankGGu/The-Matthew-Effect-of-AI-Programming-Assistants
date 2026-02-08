import java.util.*;

class Solution {
    public int minimalSteps(String[] maze) {
        int m = maze.length, n = maze[0].length();
        int sx = -1, sy = -1;
        int tx = -1, ty = -1;
        List<int[]> stones = new ArrayList<>();
        List<int[]> triggers = new ArrayList<>();
        List<int[]> treasures = new ArrayList<>();

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
                } else if (c == 'M') {
                    triggers.add(new int[]{i, j});
                } else if (c == 'X') {
                    treasures.add(new int[]{i, j});
                }
            }
        }

        int nb = triggers.size();
        int ns = stones.size();
        int nt = treasures.size();

        int[][] startDist = bfs(sx, sy, maze);

        if (nb == 0) {
            return startDist[tx][ty] == Integer.MAX_VALUE ? -1 : startDist[tx][ty];
        }

        int[][] distTriggers = new int[nb][nb + 2];
        for (int[] arr : distTriggers) {
            Arrays.fill(arr, -1);
        }

        int[][][] triggerDist = new int[nb][][];
        for (int i = 0; i < nb; i++) {
            int[] pos = triggers.get(i);
            triggerDist[i] = bfs(pos[0], pos[1], maze);
        }

        for (int i = 0; i < nb; i++) {
            int[] pos = triggers.get(i);
            int[][] dist = bfs(pos[0], pos[1], maze);

            distTriggers[i][nb] = findMinDist(startDist, stones, dist);

            for (int j = i + 1; j < nb; j++) {
                int minDist = findMinDist(triggerDist[i], stones, triggerDist[j]);
                distTriggers[i][j] = minDist;
                distTriggers[j][i] = minDist;
            }
        }

        int[][] endDist = bfs(tx, ty, maze);
        for (int i = 0; i < nb; i++) {
            distTriggers[i][nb + 1] = findMinDist(triggerDist[i], stones, endDist);
        }

        int[][] dp = new int[1 << nb][nb];
        for (int[] arr : dp) {
            Arrays.fill(arr, Integer.MAX_VALUE / 2);
        }

        for (int i = 0; i < nb; i++) {
            dp[1 << i][i] = distTriggers[i][nb];
        }

        for (int mask = 1; mask < (1 << nb); mask++) {
            for (int i = 0; i < nb; i++) {
                if ((mask & (1 << i)) == 0) continue;
                for (int j = 0; j < nb; j++) {
                    if ((mask & (1 << j)) != 0) continue;
                    int nextMask = mask | (1 << j);
                    dp[nextMask][j] = Math.min(dp[nextMask][j], dp[mask][i] + distTriggers[i][j]);
                }
            }
        }

        int res = Integer.MAX_VALUE;
        int finalMask = (1 << nb) - 1;
        for (int i = 0; i < nb; i++) {
            res = Math.min(res, dp[finalMask][i] + distTriggers[i][nb + 1]);
        }

        return res == Integer.MAX_VALUE ? -1 : res;
    }

    private int[][] bfs(int x, int y, String[] maze) {
        int m = maze.length, n = maze[0].length();
        int[][] dist = new int[m][n];
        for (int[] arr : dist) {
            Arrays.fill(arr, Integer.MAX_VALUE);
        }
        dist[x][y] = 0;
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{x, y});
        int[][] dirs = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        while (!queue.isEmpty()) {
            int[] pos = queue.poll();
            int i = pos[0], j = pos[1];
            for (int[] dir : dirs) {
                int ni = i + dir[0], nj = j + dir[1];
                if (ni >= 0 && ni < m && nj >= 0 && nj < n && maze[ni].charAt(nj) != '#' && dist[ni][nj] == Integer.MAX_VALUE) {
                    dist[ni][nj] = dist[i][j] + 1;
                    queue.offer(new int[]{ni, nj});
                }
            }
        }
        return dist;
    }

    private int findMinDist(int[][] dist1, List<int[]> stones, int[][] dist2) {
        int min = Integer.MAX_VALUE;
        for (int[] stone : stones) {
            int x = stone[0], y = stone[1];
            if (dist1[x][y] != Integer.MAX_VALUE && dist2[x][y] != Integer.MAX_VALUE) {
                min = Math.min(min, dist1[x][y] + dist2[x][y]);
            }
        }
        return min == Integer.MAX_VALUE ? -1 : min;
    }
}