class Solution {
    public List<List<Integer>> findSafePath(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] dist = new int[m][n];
        for (int i = 0; i < m; i++) {
            Arrays.fill(dist[i], Integer.MAX_VALUE);
        }
        Queue<int[]> queue = new LinkedList<>();
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 0) {
                    queue.offer(new int[]{i, j});
                    dist[i][j] = 0;
                }
            }
        }
        int[][] dirs = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            for (int[] dir : dirs) {
                int x = curr[0] + dir[0];
                int y = curr[1] + dir[1];
                if (x >= 0 && x < m && y >= 0 && y < n) {
                    if (dist[x][y] > dist[curr[0]][curr[1]] + 1) {
                        dist[x][y] = dist[curr[0]][curr[1]] + 1;
                        queue.offer(new int[]{x, y});
                    }
                }
            }
        }
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> b[2] - a[2]);
        pq.offer(new int[]{0, 0, dist[0][0]});
        boolean[][] visited = new boolean[m][n];
        visited[0][0] = true;
        int[][] pathDir = new int[m][n];
        for (int i = 0; i < m; i++) {
            Arrays.fill(pathDir[i], -1);
        }
        int[][] parent = new int[m][n];
        for (int i = 0; i < m; i++) {
            Arrays.fill(parent[i], -1);
        }
        int maxDist = -1;
        int endX = -1, endY = -1;
        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int i = curr[0], j = curr[1], d = curr[2];
            if (i == m - 1 && j == n - 1) {
                maxDist = d;
                endX = i;
                endY = j;
                break;
            }
            for (int[] dir : dirs) {
                int x = i + dir[0];
                int y = j + dir[1];
                if (x >= 0 && x < m && y >= 0 && y < n && !visited[x][y] && grid[x][y] != 0) {
                    int minD = Math.min(d, dist[x][y]);
                    pq.offer(new int[]{x, y, minD});
                    visited[x][y] = true;
                    parent[x][y] = i * n + j;
                    pathDir[x][y] = getDirIndex(dir);
                }
            }
        }
        List<List<Integer>> path = new ArrayList<>();
        if (maxDist == -1) {
            return path;
        }
        int currX = endX, currY = endY;
        while (currX != 0 || currY != 0) {
            path.add(Arrays.asList(currX, currY));
            int prev = parent[currX][currY];
            currX = prev / n;
            currY = prev % n;
        }
        path.add(Arrays.asList(0, 0));
        Collections.reverse(path);
        return path;
    }

    private int getDirIndex(int[] dir) {
        if (dir[0] == -1 && dir[1] == 0) return 0;
        if (dir[0] == 1 && dir[1] == 0) return 1;
        if (dir[0] == 0 && dir[1] == -1) return 2;
        if (dir[0] == 0 && dir[1] == 1) return 3;
        return -1;
    }
}