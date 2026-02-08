import java.util.ArrayDeque;
import java.util.Queue;

class Solution {
    public int maximumMinutes(int[][] forest) {
        int m = forest.length;
        int n = forest[0].length;

        int low = 0, high = m * n;
        int ans = -1;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (canReach(forest, mid)) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        if (ans == m * n) return 1000000000;
        return ans;
    }

    private boolean canReach(int[][] forest, int startMinutes) {
        int m = forest.length;
        int n = forest[0].length;

        int[][] copy = new int[m][n];
        for (int i = 0; i < m; i++) {
            System.arraycopy(forest[i], 0, copy[i], 0, n);
        }

        Queue<int[]> fireQueue = new ArrayDeque<>();
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (copy[i][j] == 1) {
                    fireQueue.offer(new int[]{i, j});
                }
            }
        }

        for (int i = 0; i < startMinutes; i++) {
            int size = fireQueue.size();
            for (int j = 0; j < size; j++) {
                int[] curr = fireQueue.poll();
                int r = curr[0];
                int c = curr[1];

                int[][] directions = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};
                for (int[] dir : directions) {
                    int nr = r + dir[0];
                    int nc = c + dir[1];

                    if (nr >= 0 && nr < m && nc >= 0 && nc < n && copy[nr][nc] == 0) {
                        copy[nr][nc] = 1;
                        fireQueue.offer(new int[]{nr, nc});
                    }
                }
            }
        }

        Queue<int[]> personQueue = new ArrayDeque<>();
        personQueue.offer(new int[]{0, 0});
        if (copy[0][0] == 1) return false;
        copy[0][0] = 2;

        while (!personQueue.isEmpty()) {
            int size = personQueue.size();
            for (int i = 0; i < size; i++) {
                int[] curr = personQueue.poll();
                int r = curr[0];
                int c = curr[1];

                if (r == m - 1 && c == n - 1) return true;

                int[][] directions = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};
                for (int[] dir : directions) {
                    int nr = r + dir[0];
                    int nc = c + dir[1];

                    if (nr >= 0 && nr < m && nc >= 0 && nc < n && copy[nr][nc] == 0) {
                        copy[nr][nc] = 2;
                        personQueue.offer(new int[]{nr, nc});
                    }
                }
            }

            int fireSize = fireQueue.size();
            for (int i = 0; i < fireSize; i++) {
                int[] curr = fireQueue.poll();
                int r = curr[0];
                int c = curr[1];

                int[][] directions = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};
                for (int[] dir : directions) {
                    int nr = r + dir[0];
                    int nc = c + dir[1];

                    if (nr >= 0 && nr < m && nc >= 0 && nc < n && (copy[nr][nc] == 0 || copy[nr][nc] == 2)) {
                        copy[nr][nc] = 1;
                        fireQueue.offer(new int[]{nr, nc});
                    }
                }
            }
        }

        return false;
    }
}