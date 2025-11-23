import java.util.LinkedList;
import java.util.Queue;

class Solution {
    private static final int[][] DIRS = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

    public int latestDayToCross(int row, int col, int[][] cells) {
        int low = 1;
        int high = cells.length;
        int ans = 0;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (canCross(mid, row, col, cells)) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        return ans;
    }

    private boolean canCross(int day, int R, int C, int[][] cells) {
        boolean[][] water = new boolean[R][C];
        for (int i = 0; i < day; i++) {
            water[cells[i][0] - 1][cells[i][1] - 1] = true;
        }

        Queue<int[]> queue = new LinkedList<>();
        boolean[][] visited = new boolean[R][C];

        for (int j = 0; j < C; j++) {
            if (!water[0][j]) {
                queue.offer(new int[]{0, j});
                visited[0][j] = true;
            }
        }

        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            int r = curr[0];
            int c = curr[1];

            if (r == R - 1) {
                return true;
            }

            for (int[] dir : DIRS) {
                int nr = r + dir[0];
                int nc = c + dir[1];

                if (nr >= 0 && nr < R && nc >= 0 && nc < C && !water[nr][nc] && !visited[nr][nc]) {
                    visited[nr][nc] = true;
                    queue.offer(new int[]{nr, nc});
                }
            }
        }

        return false;
    }
}