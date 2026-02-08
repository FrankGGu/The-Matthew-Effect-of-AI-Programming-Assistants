class Solution {
    public int matrixScore(int[][] A) {
        int m = A.length;
        int n = A[0].length;

        for (int i = 0; i < m; i++) {
            if (A[i][0] == 0) {
                for (int j = 0; j < n; j++) {
                    A[i][j] = 1 - A[i][j];
                }
            }
        }

        for (int j = 1; j < n; j++) {
            int count = 0;
            for (int i = 0; i < m; i++) {
                if (A[i][j] == 0) {
                    count++;
                }
            }
            if (count < m - count) {
                for (int i = 0; i < m; i++) {
                    A[i][j] = 1 - A[i][j];
                }
            }
        }

        int score = 0;
        for (int i = 0; i < m; i++) {
            int num = 0;
            for (int j = 0; j < n; j++) {
                num = num * 2 + A[i][j];
            }
            score += num;
        }

        return score;
    }
}