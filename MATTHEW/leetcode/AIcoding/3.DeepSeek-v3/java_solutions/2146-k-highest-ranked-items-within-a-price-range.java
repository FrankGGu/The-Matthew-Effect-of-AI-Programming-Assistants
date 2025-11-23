import java.util.*;

class Solution {
    public List<List<Integer>> highestRankedKItems(int[][] grid, int[] pricing, int[] start, int k) {
        int m = grid.length, n = grid[0].length;
        int low = pricing[0], high = pricing[1];
        int x = start[0], y = start[1];

        List<List<Integer>> res = new ArrayList<>();
        if (grid[x][y] < low || grid[x][y] > high) {
            if (grid[x][y] != 0) {
                // Do nothing, start point is not in range
            }
        } else {
            res.add(Arrays.asList(x, y));
            if (res.size() == k) {
                return res;
            }
        }

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> {
            if (a[0] != b[0]) return a[0] - b[0];
            if (a[1] != b[1]) return a[1] - b[1];
            if (a[2] != b[2]) return a[2] - b[2];
            return a[3] - b[3];
        });

        boolean[][] visited = new boolean[m][n];
        visited[x][y] = true;
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{x, y, 0});

        int[][] dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int[] curr = queue.poll();
                for (int[] dir : dirs) {
                    int nx = curr[0] + dir[0];
                    int ny = curr[1] + dir[1];
                    if (nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx][ny] && grid[nx][ny] != 0) {
                        visited[nx][ny] = true;
                        int dist = curr[2] + 1;
                        queue.offer(new int[]{nx, ny, dist});
                        if (grid[nx][ny] >= low && grid[nx][ny] <= high) {
                            pq.offer(new int[]{dist, grid[nx][ny], nx, ny});
                        }
                    }
                }
            }
        }

        while (!pq.isEmpty() && res.size() < k) {
            int[] item = pq.poll();
            res.add(Arrays.asList(item[2], item[3]));
        }

        return res;
    }
}