class Solution {
    public int kthLargestValue(int[][] matrix, int k) {
        int m = matrix.length, n = matrix[0].length;
        int[][] xorMatrix = new int[m][n];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                xorMatrix[i][j] = matrix[i][j] ^ (i > 0 ? xorMatrix[i - 1][j] : 0) ^ (j > 0 ? xorMatrix[i][j - 1] : 0) ^ (i > 0 && j > 0 ? xorMatrix[i - 1][j - 1] : 0);
            }
        }

        List<Integer> values = new ArrayList<>();
        for (int[] row : xorMatrix) {
            for (int val : row) {
                values.add(val);
            }
        }

        Collections.sort(values, Collections.reverseOrder());
        return values.get(k - 1);
    }
}