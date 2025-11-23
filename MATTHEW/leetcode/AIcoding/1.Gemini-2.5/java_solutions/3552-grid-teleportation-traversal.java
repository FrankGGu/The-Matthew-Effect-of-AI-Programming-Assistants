import java.util.*;

class Solution {
    public int minMoves(char[][] grid) {
        int R = grid.length;
        int C = grid[0].length;

        int startR = -1, startC = -1;
        int endR = -1, endC = -1;

        Map<Character, List<int[]>> teleports = new HashMap<>();
        for (int r = 0; r < R; r++) {
            for (int c = 0; c < C; c++) {
                if (grid[r][c] == 'S') {
                    startR = r;
                    startC = c;
                } else if (grid[r][c] == 'E') {
                    endR = r;
                    endC = c;
                } else if (grid[r][c] >= 'A' && grid[r][c] <= 'Z') {
                    teleports.computeIfAbsent(grid[r][c], k -> new ArrayList<>()).add(new int[]{r, c});
                }
            }
        }

        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{startR, startC, 0});

        boolean[][] visited = new boolean[R][C];
        visited[startR][startC] = true;

        boolean[] teleportGroupUsed = new boolean[26];

        int[] dr = {-1, 1, 0, 0};
        int[] dc = {0, 0, -1, 1};

        while (!queue.isEmpty()) {
            int[] current = queue.poll();
            int r = current[0];
            int c = current[1];
            int dist = current[2];

            if (r == endR && c == endC) {
                return dist;
            }

            for (int i = 0; i < 4; i++) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                if (nr >= 0 && nr < R && nc >= 0 && nc < C && grid[nr][nc] != '#' && !visited[nr][nc]) {
                    visited[nr][nc] = true;
                    queue.offer(new int[]{nr, nc, dist + 1});
                }
            }

            char cellChar = grid[r][c];
            if (cellChar >= 'A' && cellChar <= 'Z') {
                int groupIndex = cellChar - 'A';
                if (!teleportGroupUsed[groupIndex]) {
                    teleportGroupUsed[groupIndex] = true;
                    List<int[]> portalPoints = teleports.get(cellChar);
                    for (int[] portalCoord : portalPoints) {
                        int pr = portalCoord[0];
                        int pc = portalCoord[1];
                        if (!visited[pr][pc]) {
                            visited[pr][pc] = true;
                            queue.offer(new int[]{pr, pc, dist});
                        }
                    }
                }
            }
        }

        return -1;
    }
}