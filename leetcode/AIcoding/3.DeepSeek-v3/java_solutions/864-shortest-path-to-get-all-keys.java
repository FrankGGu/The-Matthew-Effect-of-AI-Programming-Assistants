class Solution {
    public int shortestPathAllKeys(String[] grid) {
        int m = grid.length;
        int n = grid[0].length();
        int allKeys = 0;
        int startX = -1, startY = -1;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                char c = grid[i].charAt(j);
                if (c == '@') {
                    startX = i;
                    startY = j;
                } else if (c >= 'a' && c <= 'f') {
                    allKeys |= 1 << (c - 'a');
                }
            }
        }

        int[][][] visited = new int[m][n][allKeys + 1];
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{startX, startY, 0});
        visited[startX][startY][0] = 1;

        int[][] dirs = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        int steps = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int[] current = queue.poll();
                int x = current[0];
                int y = current[1];
                int keys = current[2];

                if (keys == allKeys) {
                    return steps;
                }

                for (int[] dir : dirs) {
                    int nx = x + dir[0];
                    int ny = y + dir[1];

                    if (nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx].charAt(ny) != '#') {
                        char c = grid[nx].charAt(ny);
                        int newKeys = keys;

                        if (c >= 'a' && c <= 'f') {
                            newKeys |= (1 << (c - 'a'));
                        }

                        if (visited[nx][ny][newKeys] == 0) {
                            if (c >= 'A' && c <= 'F' && (keys & (1 << (c - 'A'))) == 0) {
                                continue;
                            }
                            visited[nx][ny][newKeys] = 1;
                            queue.offer(new int[]{nx, ny, newKeys});
                        }
                    }
                }
            }
            steps++;
        }

        return -1;
    }
}