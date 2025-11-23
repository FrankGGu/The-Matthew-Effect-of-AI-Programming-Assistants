class Solution {
    public double knightProbability(int n, int k, int row, int column) {
        if (k == 0) {
            return 1.0;
        }

        double[][] prevDp = new double[n][n];
        prevDp[row][column] = 1.0;

        int[] dr = {-2, -2, -1, -1, 1, 1, 2, 2};
        int[] dc = {-1, 1, -2, 2, -2, 2, -1, 1};

        for (int moves = 1; moves <= k; moves++) {
            double[][] currentDp = new double[n][n];
            for (int r = 0; r < n; r++) {
                for (int c = 0; c < n; c++) {
                    if (prevDp[r][c] > 0) {
                        for (int i = 0; i < 8; i++) {
                            int nextR = r + dr[i];
                            int nextC = c + dc[i];

                            if (nextR >= 0 && nextR < n && nextC >= 0 && nextC < n) {
                                currentDp[nextR][nextC] += prevDp[r][c] / 8.0;
                            }
                        }
                    }
                }
            }
            prevDp = currentDp;
        }

        double totalProbability = 0.0;
        for (int r = 0; r < n; r++) {
            for (int c = 0; c < n; c++) {
                totalProbability += prevDp[r][c];
            }
        }

        return totalProbability;
    }
}