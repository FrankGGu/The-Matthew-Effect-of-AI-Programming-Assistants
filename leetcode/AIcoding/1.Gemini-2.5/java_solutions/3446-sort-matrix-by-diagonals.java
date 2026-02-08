import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public int[][] diagonalSort(int[][] mat) {
        int m = mat.length;
        int n = mat[0].length;

        Map<Integer, List<Integer>> diagonals = new HashMap<>();

        for (int r = 0; r < m; r++) {
            for (int c = 0; c < n; c++) {
                int diff = r - c;
                diagonals.computeIfAbsent(diff, k -> new ArrayList<>()).add(mat[r][c]);
            }
        }

        for (Map.Entry<Integer, List<Integer>> entry : diagonals.entrySet()) {
            Collections.sort(entry.getValue());
        }

        Map<Integer, Integer> currentIndices = new HashMap<>();
        for (int r = 0; r < m; r++) {
            for (int c = 0; c < n; c++) {
                int diff = r - c;
                List<Integer> sortedDiagonal = diagonals.get(diff);
                int idx = currentIndices.getOrDefault(diff, 0);
                mat[r][c] = sortedDiagonal.get(idx);
                currentIndices.put(diff, idx + 1);
            }
        }

        return mat;
    }
}