import java.util.*;

class Solution {
    private int[][] dirs = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

    public int cutOffTree(List<List<Integer>> forest) {
        if (forest == null || forest.size() == 0) return 0;
        int m = forest.size(), n = forest.get(0).size();
        List<int[]> trees = new ArrayList<>();
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int height = forest.get(i).get(j);
                if (height > 1) {
                    trees.add(new int[]{height, i, j});
                }
            }
        }
        Collections.sort(trees, (a, b) -> a[0] - b[0]);
        int res = 0;
        int startX = 0, startY = 0;
        for (int[] tree : trees) {
            int dist = bfs(forest, startX, startY, tree[1], tree[2], m, n);
            if (dist == -1) return -1;
            res += dist;
            startX = tree[1];
            startY = tree[2];
        }
        return res;
    }

    private int bfs(List<List<Integer>> forest, int startX, int startY, int targetX, int targetY, int m, int n) {
        if (startX == targetX && startY == targetY) return 0;
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{startX, startY});
        boolean[][] visited = new boolean[m][n];
        visited[startX][startY] = true;
        int steps = 0;
        while (!queue.isEmpty()) {
            int size = queue.size();
            steps++;
            for (int i = 0; i < size; i++) {
                int[] curr = queue.poll();
                for (int[] dir : dirs) {
                    int x = curr[0] + dir[0];
                    int y = curr[1] + dir[1];
                    if (x < 0 || x >= m || y < 0 || y >= n || forest.get(x).get(y) == 0 || visited[x][y]) continue;
                    if (x == targetX && y == targetY) return steps;
                    visited[x][y] = true;
                    queue.offer(new int[]{x, y});
                }
            }
        }
        return -1;
    }
}