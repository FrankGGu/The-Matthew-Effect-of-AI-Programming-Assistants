class Solution {
    public List<List<Integer>> bicycleYard(int[] position, int[][] terrain, int[][] obstacle) {
        int m = terrain.length, n = terrain[0].length;
        int[][] dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
        List<List<Integer>> res = new ArrayList<>();
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{position[0], position[1], 1});
        boolean[][][] visited = new boolean[m][n][102];
        visited[position[0]][position[1]][1] = true;

        while (!queue.isEmpty()) {
            int[] cur = queue.poll();
            int x = cur[0], y = cur[1], speed = cur[2];
            for (int[] dir : dirs) {
                int nx = x + dir[0], ny = y + dir[1];
                if (nx < 0 || nx >= m || ny < 0 || ny >= n) continue;
                int delta = terrain[x][y] - terrain[nx][ny] - obstacle[nx][ny];
                int newSpeed = speed + delta;
                if (newSpeed <= 0) continue;
                if (newSpeed >= 102) continue;
                if (visited[nx][ny][newSpeed]) continue;
                visited[nx][ny][newSpeed] = true;
                if (newSpeed == 1) {
                    res.add(Arrays.asList(nx, ny));
                }
                queue.offer(new int[]{nx, ny, newSpeed});
            }
        }
        res.sort((a, b) -> {
            if (a.get(0) != b.get(0)) return a.get(0) - b.get(0);
            return a.get(1) - b.get(1);
        });
        return res;
    }
}