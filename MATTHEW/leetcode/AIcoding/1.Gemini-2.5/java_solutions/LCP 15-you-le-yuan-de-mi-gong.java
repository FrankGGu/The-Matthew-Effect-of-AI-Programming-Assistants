import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public boolean hasPath(int[][] maze, int[] start, int[] destination) {
        int m = maze.length;
        int n = maze[0].length;
        boolean[][] visited = new boolean[m][n];
        Queue<int[]> queue = new LinkedList<>();

        queue.offer(start);
        visited[start[0]][start[1]] = true;

        int[][] dirs = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            int currR = curr[0];
            int currC = curr[1];

            for (int[] dir : dirs) {
                int nextR = currR;
                int nextC = currC;

                while (nextR + dir[0] >= 0 && nextR + dir[0] < m &&
                       nextC + dir[1] >= 0 && nextC + dir[1] < n &&
                       maze[nextR + dir[0]][nextC + dir[1]] == 0) {
                    nextR += dir[0];
                    nextC += dir[1];
                }

                if (nextR == destination[0] && nextC == destination[1]) {
                    return true;
                }

                if (!visited[nextR][nextC]) {
                    visited[nextR][nextC] = true;
                    queue.offer(new int[]{nextR, nextC});
                }
            }
        }

        return false;
    }
}