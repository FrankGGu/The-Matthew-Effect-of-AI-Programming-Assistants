import java.util.*;

class Solution {
    public int cutOffTree(List<List<Integer>> forest) {
        int m = forest.size(), n = forest.get(0).size();
        List<int[]> trees = new ArrayList<>();
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (forest.get(i).get(j) > 1) {
                    trees.add(new int[] {forest.get(i).get(j), i, j});
                }
            }
        }
        Collections.sort(trees, (a, b) -> Integer.compare(a[0], b[0]));

        int totalSteps = 0, startX = 0, startY = 0;
        for (int[] tree : trees) {
            int steps = bfs(forest, startX, startY, tree[1], tree[2]);
            if (steps == -1) return -1;
            totalSteps += steps;
            startX = tree[1];
            startY = tree[2];
        }
        return totalSteps;
    }

    private int bfs(List<List<Integer>> forest, int startX, int startY, int targetX, int targetY) {
        int m = forest.size(), n = forest.get(0).size();
        boolean[][] visited = new boolean[m][n];
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[] {startX, startY, 0});
        visited[startX][startY] = true;

        int[][] directions = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};

        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            int x = curr[0], y = curr[1], steps = curr[2];
            if (x == targetX && y == targetY) return steps;

            for (int[] dir : directions) {
                int newX = x + dir[0], newY = y + dir[1];
                if (newX >= 0 && newX < m && newY >= 0 && newY < n && forest.get(newX).get(newY) > 0 && !visited[newX][newY]) {
                    visited[newX][newY] = true;
                    queue.offer(new int[] {newX, newY, steps + 1});
                }
            }
        }
        return -1;
    }
}