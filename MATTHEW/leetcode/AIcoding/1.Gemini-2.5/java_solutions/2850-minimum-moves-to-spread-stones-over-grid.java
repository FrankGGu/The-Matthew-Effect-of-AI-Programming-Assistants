import java.util.ArrayList;
import java.util.List;

class Solution {
    public int minimumMoves(int[][] grid) {
        List<int[]> excess = new ArrayList<>();
        List<int[]> empty = new ArrayList<>();

        for (int r = 0; r < 3; r++) {
            for (int c = 0; c < 3; c++) {
                if (grid[r][c] > 1) {
                    for (int i = 0; i < grid[r][c] - 1; i++) {
                        excess.add(new int[]{r, c});
                    }
                } else if (grid[r][c] == 0) {
                    empty.add(new int[]{r, c});
                }
            }
        }

        // If there are no excess stones, then there are no empty cells either (total stones is 9).
        // The grid is already balanced, so 0 moves are needed.
        if (excess.isEmpty()) {
            return 0;
        }

        int[] minTotalMoves = {Integer.MAX_VALUE};
        boolean[] visitedEmpty = new boolean[empty.size()];

        backtrack(0, 0, excess, empty, visitedEmpty, minTotalMoves);

        return minTotalMoves[0];
    }

    private void backtrack(int excessIndex, int currentMoves, List<int[]> excess, List<int[]> empty, boolean[] visitedEmpty, int[] minTotalMoves) {
        if (excessIndex == excess.size()) {
            minTotalMoves[0] = Math.min(minTotalMoves[0], currentMoves);
            return;
        }

        if (currentMoves >= minTotalMoves[0]) {
            return;
        }

        int[] fromCoords = excess.get(excessIndex);
        int fromR = fromCoords[0];
        int fromC = fromCoords[1];

        for (int i = 0; i < empty.size(); i++) {
            if (!visitedEmpty[i]) {
                visitedEmpty[i] = true;
                int[] toCoords = empty.get(i);
                int toR = toCoords[0];
                int toC = toCoords[1];
                int dist = Math.abs(fromR - toR) + Math.abs(fromC - toC);

                backtrack(excessIndex + 1, currentMoves + dist, excess, empty, visitedEmpty, minTotalMoves);

                visitedEmpty[i] = false;
            }
        }
    }
}