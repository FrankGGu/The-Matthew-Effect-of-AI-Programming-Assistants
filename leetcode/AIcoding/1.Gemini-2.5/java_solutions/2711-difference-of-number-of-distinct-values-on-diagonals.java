import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

class Solution {
    public int[][] differenceOfDistinctValues(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        Map<Integer, Set<Integer>> mainDiagonals = new HashMap<>();
        Map<Integer, Set<Integer>> antiDiagonals = new HashMap<>();

        for (int r = 0; r < m; r++) {
            for (int c = 0; c < n; c++) {
                int mainDiagKey = r - c;
                int antiDiagKey = r + c;

                mainDiagonals.computeIfAbsent(mainDiagKey, k -> new HashSet<>()).add(grid[r][c]);
                antiDiagonals.computeIfAbsent(antiDiagKey, k -> new HashSet<>()).add(grid[r][c]);
            }
        }

        int[][] answer = new int[m][n];
        for (int r = 0; r < m; r++) {
            for (int c = 0; c < n; c++) {
                int mainDiagKey = r - c;
                int antiDiagKey = r + c;

                int distinctCountMainDiag = mainDiagonals.get(mainDiagKey).size();
                int distinctCountAntiDiag = antiDiagonals.get(antiDiagKey).size();

                answer[r][c] = Math.abs(distinctCountMainDiag - distinctCountAntiDiag);
            }
        }

        return answer;
    }
}