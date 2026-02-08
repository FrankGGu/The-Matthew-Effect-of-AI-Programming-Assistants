class Solution {
    public int conveyorBelt(String[] grid, String[] changes, int startX, int startY, int endX, int endY) {
        int m = grid.length;
        int n = grid[0].length();
        int[][] dist = new int[m][n];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                dist[i][j] = Integer.MAX_VALUE;
            }
        }
        dist[startX][startY] = 0;

        int[][] dirs = new int[][]{{0, 1}, {0, -1}, {1, 0}, {-1, 0}};
        char[] symbols = new char[]{'>', '<', 'v', '^'};

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[2] - b[2]);
        pq.offer(new int[]{startX, startY, 0});

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int x = curr[0];
            int y = curr[1];
            int d = curr[2];

            if (d > dist[x][y]) continue;

            for (int i = 0; i < 4; i++) {
                int nx = x + dirs[i][0];
                int ny = y + dirs[i][1];

                if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                    int cost = (grid[x].charAt(y) == symbols[i]) ? 0 : 1;
                    if (dist[nx][ny] > dist[x][y] + cost) {
                        dist[nx][ny] = dist[x][y] + cost;
                        pq.offer(new int[]{nx, ny, dist[nx][ny]});
                    }
                }
            }
        }

        for(String change : changes) {
            String[] parts = change.split(" ");
            int x = Integer.parseInt(parts[0]);
            int y = Integer.parseInt(parts[1]);
            char newDir = parts[2].charAt(0);
            grid[x] = grid[x].substring(0, y) + newDir + grid[x].substring(y + 1);

            dist = new int[m][n];
            for (int i = 0; i < m; i++) {
                for (int j = 0; j < n; j++) {
                    dist[i][j] = Integer.MAX_VALUE;
                }
            }
            dist[startX][startY] = 0;

            pq = new PriorityQueue<>((a, b) -> a[2] - b[2]);
            pq.offer(new int[]{startX, startY, 0});

            while (!pq.isEmpty()) {
                int[] curr = pq.poll();
                int x_curr = curr[0];
                int y_curr = curr[1];
                int d_curr = curr[2];

                if (d_curr > dist[x_curr][y_curr]) continue;

                for (int i = 0; i < 4; i++) {
                    int nx = x_curr + dirs[i][0];
                    int ny = y_curr + dirs[i][1];

                    if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                        int cost = (grid[x_curr].charAt(y_curr) == symbols[i]) ? 0 : 1;
                        if (dist[nx][ny] > dist[x_curr][y_curr] + cost) {
                            dist[nx][ny] = dist[x_curr][y_curr] + cost;
                            pq.offer(new int[]{nx, ny, dist[nx][ny]});
                        }
                    }
                }
            }

        }

        return (dist[endX][endY] == Integer.MAX_VALUE) ? -1 : dist[endX][endY];
    }
}