import java.util.HashSet;
import java.util.Set;

class Solution {
    public long[] countBlackBlocks(int m, int n, int[][] coordinates) {
        long[] ans = new long[5];
        Set<Long> blackCells = new HashSet<>();

        for (int[] coord : coordinates) {
            int r = coord[0];
            int c = coord[1];
            blackCells.add((long) r * n + c);
        }

        Set<Long> visitedSquareTopLefts = new HashSet<>();

        for (int[] coord : coordinates) {
            int r = coord[0];
            int c = coord[1];

            // (r, c) is the top-left cell of a 2x2 square
            if (r + 1 < m && c + 1 < n) {
                visitedSquareTopLefts.add((long) r * n + c);
            }
            // (r, c) is the top-right cell of a 2x2 square
            if (r + 1 < m && c - 1 >= 0) {
                visitedSquareTopLefts.add((long) r * n + (c - 1));
            }
            // (r, c) is the bottom-left cell of a 2x2 square
            if (r - 1 >= 0 && c + 1 < n) {
                visitedSquareTopLefts.add((long) (r - 1) * n + c);
            }
            // (r, c) is the bottom-right cell of a 2x2 square
            if (r - 1 >= 0 && c - 1 >= 0) {
                visitedSquareTopLefts.add((long) (r - 1) * n + (c - 1));
            }
        }

        for (long squareKey : visitedSquareTopLefts) {
            int sr = (int) (squareKey / n);
            int sc = (int) (squareKey % n);

            int count = 0;
            if (blackCells.contains((long) sr * n + sc)) {
                count++;
            }
            if (blackCells.contains((long) sr * n + (sc + 1))) {
                count++;
            }
            if (blackCells.contains((long) (sr + 1) * n + sc)) {
                count++;
            }
            if (blackCells.contains((long) (sr + 1) * n + (sc + 1))) {
                count++;
            }
            ans[count]++;
        }

        long totalPossibleSquares = (long) (m - 1) * (n - 1);
        long sumOfNonZeroSquares = 0;
        for (int i = 1; i <= 4; i++) {
            sumOfNonZeroSquares += ans[i];
        }
        ans[0] = totalPossibleSquares - sumOfNonZeroSquares;

        return ans;
    }
}