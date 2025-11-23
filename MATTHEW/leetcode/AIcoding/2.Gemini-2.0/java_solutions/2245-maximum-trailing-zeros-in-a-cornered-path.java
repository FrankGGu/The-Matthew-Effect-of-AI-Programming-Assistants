class Solution {
    public int maxTrailingZeros(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] rowTwo = new int[m][n];
        int[][] rowFive = new int[m][n];
        int[][] colTwo = new int[m][n];
        int[][] colFive = new int[m][n];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int num = grid[i][j];
                while (num % 2 == 0 && num > 0) {
                    rowTwo[i][j]++;
                    num /= 2;
                }
                num = grid[i][j];
                while (num % 5 == 0 && num > 0) {
                    rowFive[i][j]++;
                    num /= 5;
                }
            }
        }

        for (int j = 0; j < n; j++) {
            for (int i = 0; i < m; i++) {
                int num = grid[i][j];
                while (num % 2 == 0 && num > 0) {
                    colTwo[i][j]++;
                    num /= 2;
                }
                num = grid[i][j];
                while (num % 5 == 0 && num > 0) {
                    colFive[i][j]++;
                    num /= 5;
                }
            }
        }

        for (int i = 0; i < m; i++) {
            for (int j = 1; j < n; j++) {
                rowTwo[i][j] += rowTwo[i][j - 1];
                rowFive[i][j] += rowFive[i][j - 1];
            }
        }

        for (int j = 0; j < n; j++) {
            for (int i = 1; i < m; i++) {
                colTwo[i][j] += colTwo[i - 1][j];
                colFive[i][j] += colFive[i - 1][j];
            }
        }

        int maxZeros = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int twoCount = 0;
                int fiveCount = 0;

                twoCount = rowTwo[i][j];
                fiveCount = rowFive[i][j];
                if (j > 0) {
                    twoCount += colTwo[m - 1][j] - colTwo[i][j];
                    fiveCount += colFive[m - 1][j] - colFive[i][j];
                } else {
                    twoCount += colTwo[m - 1][j] - colTwo[i][j];
                    fiveCount += colFive[m - 1][j] - colFive[i][j];
                }
                maxZeros = Math.max(maxZeros, Math.min(twoCount, fiveCount));

                twoCount = rowTwo[i][n - 1];
                fiveCount = rowFive[i][n - 1];

                if(j > 0){
                    twoCount -= rowTwo[i][j-1];
                    fiveCount -= rowFive[i][j-1];
                }

                twoCount += colTwo[m - 1][j] - colTwo[i][j];
                fiveCount += colFive[m - 1][j] - colFive[i][j];

                maxZeros = Math.max(maxZeros, Math.min(twoCount, fiveCount));

                twoCount = colTwo[i][j];
                fiveCount = colFive[i][j];

                twoCount += rowTwo[i][n-1] - rowTwo[i][j];
                fiveCount += rowFive[i][n-1] - rowFive[i][j];

                maxZeros = Math.max(maxZeros, Math.min(twoCount, fiveCount));

                twoCount = colTwo[m-1][j];
                fiveCount = colFive[m-1][j];

                if(i>0){
                    twoCount -= colTwo[i-1][j];
                    fiveCount -= colFive[i-1][j];
                }

                twoCount += rowTwo[i][n-1] - rowTwo[i][j];
                fiveCount += rowFive[i][n-1] - rowFive[i][j];

                maxZeros = Math.max(maxZeros, Math.min(twoCount, fiveCount));
            }
        }

        return maxZeros;
    }
}