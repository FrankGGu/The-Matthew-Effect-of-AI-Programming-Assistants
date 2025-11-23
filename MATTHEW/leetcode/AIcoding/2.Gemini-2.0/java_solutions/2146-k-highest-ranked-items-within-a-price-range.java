import java.util.*;

class Solution {
    public List<List<Integer>> highestRankedKItems(int[][] grid, int[] pricing, int[] start, int k) {
        int m = grid.length;
        int n = grid[0].length;
        int[] dx = {0, 0, 1, -1};
        int[] dy = {1, -1, 0, 0};

        List<int[]> items = new ArrayList<>();
        Queue<int[]> queue = new LinkedList<>();
        boolean[][] visited = new boolean[m][n];

        queue.offer(start);
        visited[start[0]][start[1]] = true;
        int distance = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int[] curr = queue.poll();
                int x = curr[0];
                int y = curr[1];

                if (grid[x][y] != 0) {
                    if (grid[x][y] >= pricing[0] && grid[x][y] <= pricing[1]) {
                        items.add(new int[]{distance, grid[x][y], x, y});
                    }
                }

                for (int j = 0; j < 4; j++) {
                    int nx = x + dx[j];
                    int ny = y + dy[j];

                    if (nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] != 0 && !visited[nx][ny]) {
                        queue.offer(new int[]{nx, ny});
                        visited[nx][ny] = true;
                    }
                }
            }
            distance++;
        }

        Collections.sort(items, (a, b) -> {
            if (a[0] != b[0]) {
                return a[0] - b[0];
            } else if (a[1] != b[1]) {
                return a[1] - b[1];
            } else if (a[2] != b[2]) {
                return a[2] - b[2];
            } else {
                return a[3] - b[3];
            }
        });

        List<List<Integer>> result = new ArrayList<>();
        for (int i = 0; i < Math.min(k, items.size()); i++) {
            result.add(Arrays.asList(items.get(i)[2], items.get(i)[3]));
        }

        return result;
    }
}