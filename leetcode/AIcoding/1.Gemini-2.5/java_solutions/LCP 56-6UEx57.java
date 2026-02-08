import java.util.LinkedList;
import java.util.Map;
import java.util.Queue;
import java.util.HashMap;

class Solution {
    private static final int[] DR = {-1, 1, 0, 0};
    private static final int[] DC = {0, 0, -1, 1};

    public int solve(char[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;

        int startR = -1, startC = -1;
        int endR = -1, endC = -1;
        int numTokens = 0;
        Map<Character, Integer> tokenCharToIndex = new HashMap<>();

        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) {
                if (grid[r][c] == 'S') {
                    startR = r;
                    startC = c;
                } else if (grid[r][c] == 'E') {
                    endR = r;
                    endC = c;
                } else if (grid[r][c] >= '1' && grid[r][c] <= '9') {
                    tokenCharToIndex.put(grid[r][c], numTokens++);
                }
            }
        }

        // State: {row, col, collected_tokens_mask, steps}
        Queue<int[]> queue = new LinkedList<>();
        // visited[row][col][mask]
        boolean[][][] visited = new boolean[rows][cols][1 << numTokens];

        queue.offer(new int[]{startR, startC, 0, 0});
        visited[startR][startC][0] = true;

        int allTokensMask = (1 << numTokens) - 1;

        while (!queue.isEmpty()) {
            int[] current = queue.poll();
            int r = current[0];
            int c = current[1];
            int currentMask = current[2];
            int steps = current[3];

            if (currentMask == allTokensMask && r == endR && c == endC) {
                return steps;
            }

            for (int i = 0; i < 4; i++) {
                int nr = r + DR[i];
                int nc = c + DC[i];

                if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && grid[nr][nc] != '#') {
                    int nextMask = currentMask;
                    char cell = grid[nr][nc];

                    if (cell >= '1' && cell <= '9') {
                        int tokenIdx = tokenCharToIndex.get(cell);
                        nextMask |= (1 << tokenIdx);
                    }

                    if (!visited[nr][nc][nextMask]) {
                        visited[nr][nc][nextMask] = true;
                        queue.offer(new int[]{nr, nc, nextMask, steps + 1});
                    }
                }
            }
        }

        return -1;
    }
}