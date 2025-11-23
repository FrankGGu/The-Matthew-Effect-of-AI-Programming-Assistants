class Solution {
    public int[][] matrixRankTransform(int[][] matrix) {
        int m = matrix.length, n = matrix[0].length;
        int[][] rank = new int[m][n];
        int[] rowMax = new int[m];
        int[] colMax = new int[n];
        int[][] entries = new int[m * n][3];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                entries[i * n + j] = new int[]{matrix[i][j], i, j};
            }
        }

        Arrays.sort(entries, (a, b) -> a[0] - b[0]);

        for (int i = 0; i < m * n; i++) {
            int value = entries[i][0];
            int r = entries[i][1], c = entries[i][2];
            int currentRank = Math.max(rowMax[r], colMax[c]) + 1;
            rank[r][c] = currentRank;
            rowMax[r] = currentRank;
            colMax[c] = currentRank;
        }

        return rank;
    }
}