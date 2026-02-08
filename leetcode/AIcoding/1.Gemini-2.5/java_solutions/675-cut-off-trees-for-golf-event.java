import java.util.*;

class Solution {
    private static final int[][] DIRS = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

    public int cutOffTree(List<List<Integer>> forest) {
        if (forest == null || forest.isEmpty() || forest.get(0).isEmpty()) {
            return 0;
        }

        List<int[]> trees = new ArrayList<>();
        int rows = forest.size();
        int cols = forest.get(0).size();

        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) {
                if (forest.get(r).get(c) > 1) {
                    trees.add(new int[]{forest.get(r).get(c), r, c});
                }
            }
        }

        trees.sort((a, b) -> Integer.compare(a[0], b[0]));

        int totalSteps = 0;
        int currentR = 0;
        int currentC = 0;

        for (int[] tree : trees) {
            int targetR = tree[1];
            int targetC = tree[2];

            int steps = bfs(forest, currentR, currentC, targetR, targetC, rows, cols);

            if (steps == -1) {
                return -1;
            }

            totalSteps += steps;
            currentR = targetR;
            currentC = targetC;
        }

        return totalSteps;
    }

    private int bfs(List<List<Integer>> forest, int startR, int startC, int endR, int endC, int rows, int cols) {
        if (startR == endR && startC == endC) {
            return 0;
        }

        Queue<int[]> queue = new LinkedList<>();
        boolean[][] visited = new boolean[rows][cols];

        queue.offer(new int[]{startR, startC, 0});
        visited[startR][startC] = true;

        while (!queue.isEmpty()) {
            int[] current = queue.poll();
            int r = current[0];
            int c = current[1];
            int steps = current[2];

            for (int[] dir : DIRS) {
                int nr = r + dir[0];
                int nc = c + dir[1];

                if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && !visited[nr][nc] && forest.get(nr).get(nc) != 0) {
                    if (nr == endR && nc == endC) {
                        return steps + 1;
                    }
                    visited[nr][nc] = true;
                    queue.offer(new int[]{nr, nc, steps + 1});
                }
            }
        }

        return -1;
    }
}