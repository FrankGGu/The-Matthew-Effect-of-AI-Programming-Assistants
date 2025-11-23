class Solution {
    private static final int[][] DIRECTIONS = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

    public int latestDayToCross(int row, int col, int[][] cells) {
        int left = 1, right = cells.length;
        int ans = 0;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (canCross(row, col, cells, mid)) {
                ans = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return ans;
    }

    private boolean canCross(int row, int col, int[][] cells, int day) {
        int[][] grid = new int[row][col];
        for (int i = 0; i < day; i++) {
            int r = cells[i][0] - 1;
            int c = cells[i][1] - 1;
            grid[r][c] = 1;
        }

        Queue<int[]> queue = new LinkedList<>();
        for (int c = 0; c < col; c++) {
            if (grid[0][c] == 0) {
                queue.offer(new int[]{0, c});
                grid[0][c] = -1;
            }
        }

        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            int r = curr[0], c = curr[1];
            if (r == row - 1) {
                return true;
            }
            for (int[] dir : DIRECTIONS) {
                int newR = r + dir[0], newC = c + dir[1];
                if (newR >= 0 && newR < row && newC >= 0 && newC < col && grid[newR][newC] == 0) {
                    grid[newR][newC] = -1;
                    queue.offer(new int[]{newR, newC});
                }
            }
        }
        return false;
    }
}