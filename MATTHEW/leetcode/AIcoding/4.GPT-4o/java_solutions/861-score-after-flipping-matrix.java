class Solution {
    public int matrixScore(int[][] A) {
        int rows = A.length, cols = A[0].length;

        // Flip rows to maximize leading 1s
        for (int i = 0; i < rows; i++) {
            if (A[i][0] == 0) {
                for (int j = 0; j < cols; j++) {
                    A[i][j] = 1 - A[i][j];
                }
            }
        }

        int score = 0;
        for (int j = 0; j < cols; j++) {
            int count = 0;
            for (int i = 0; i < rows; i++) {
                count += A[i][j];
            }
            score += Math.max(count, rows - count) * (1 << (cols - 1 - j));
        }

        return score;
    }
}