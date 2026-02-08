import java.util.*;

class Solution {
    public int[][] matrixRankTransform(int[][] matrix) {
        int m = matrix.length;
        int n = matrix[0].length;
        int[][] rank = new int[m][n];
        int[] rowRank = new int[m];
        int[] colRank = new int[n];

        Map<Integer, List<int[]>> valueMap = new TreeMap<>();
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                valueMap.computeIfAbsent(matrix[i][j], k -> new ArrayList<>()).add(new int[]{i, j});
            }
        }

        for (int value : valueMap.keySet()) {
            List<int[]> coordinates = valueMap.get(value);
            int[] parent = new int[m + n];
            int[] maxRank = new int[m + n];
            for (int i = 0; i < m + n; i++) {
                parent[i] = i;
                maxRank[i] = (i < m) ? rowRank[i] : colRank[i - m];
            }

            for (int[] coordinate : coordinates) {
                int row = coordinate[0];
                int col = coordinate[1] + m;
                int pRow = find(parent, row);
                int pCol = find(parent, col);
                if (pRow != pCol) {
                    parent[pRow] = pCol;
                    maxRank[pCol] = Math.max(maxRank[pRow], maxRank[pCol]);
                }
            }

            for (int[] coordinate : coordinates) {
                int row = coordinate[0];
                int col = coordinate[1];
                int p = find(parent, row);
                int newRank = maxRank[p] + 1;
                rank[row][col] = newRank;
                rowRank[row] = newRank;
                colRank[col] = newRank;
            }
        }

        return rank;
    }

    private int find(int[] parent, int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent, parent[i]);
    }
}