class Solution {
    public int conveyorBelt(String[] matrix, int[] start, int[] end) {
        int m = matrix.length;
        int n = matrix[0].length();
        int[][] directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        char[] dirChars = {'^', 'v', '<', '>'};
        int[][] dist = new int[m][n];
        for (int i = 0; i < m; i++) {
            Arrays.fill(dist[i], Integer.MAX_VALUE);
        }
        dist[start[0]][start[1]] = 0;
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[2] - b[2]);
        pq.offer(new int[]{start[0], start[1], 0});

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int x = curr[0];
            int y = curr[1];
            int cost = curr[2];
            if (x == end[0] && y == end[1]) {
                return cost;
            }
            if (cost > dist[x][y]) {
                continue;
            }
            for (int i = 0; i < 4; i++) {
                int nx = x + directions[i][0];
                int ny = y + directions[i][1];
                if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                    int newCost = cost + (matrix[x].charAt(y) == dirChars[i] ? 0 : 1);
                    if (newCost < dist[nx][ny]) {
                        dist[nx][ny] = newCost;
                        pq.offer(new int[]{nx, ny, newCost});
                    }
                }
            }
        }
        return -1;
    }
}