import java.util.*;

class Solution {
    public int cutOffTree(List<List<Integer>> forest) {
        int m = forest.size();
        int n = forest.get(0).size();
        List<int[]> trees = new ArrayList<>();
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (forest.get(i).get(j) > 1) {
                    trees.add(new int[]{i, j, forest.get(i).get(j)});
                }
            }
        }
        Collections.sort(trees, (a, b) -> a[2] - b[2]);

        int sx = 0, sy = 0;
        int ans = 0;
        for (int[] tree : trees) {
            int tx = tree[0], ty = tree[1];
            int dist = bfs(forest, sx, sy, tx, ty);
            if (dist == -1) {
                return -1;
            }
            ans += dist;
            sx = tx;
            sy = ty;
        }
        return ans;
    }

    private int bfs(List<List<Integer>> forest, int sx, int sy, int tx, int ty) {
        int m = forest.size();
        int n = forest.get(0).size();
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{sx, sy, 0});
        boolean[][] visited = new boolean[m][n];
        visited[sx][sy] = true;
        int[] dx = {0, 0, 1, -1};
        int[] dy = {1, -1, 0, 0};

        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            int x = curr[0], y = curr[1], dist = curr[2];
            if (x == tx && y == ty) {
                return dist;
            }
            for (int i = 0; i < 4; i++) {
                int nx = x + dx[i], ny = y + dy[i];
                if (nx >= 0 && nx < m && ny >= 0 && ny < n && forest.get(nx).get(ny) > 0 && !visited[nx][ny]) {
                    queue.offer(new int[]{nx, ny, dist + 1});
                    visited[nx][ny] = true;
                }
            }
        }
        return -1;
    }
}