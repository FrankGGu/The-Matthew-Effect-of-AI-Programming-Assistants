class Solution {
    public int[] pathsWithMaxScore(List<String> board) {
        int n = board.size();
        int mod = (int)1e9 + 7;
        int[][] dpSum = new int[n][n];
        int[][] dpCount = new int[n][n];

        dpSum[n-1][n-1] = 0;
        dpCount[n-1][n-1] = 1;

        for (int i = n-1; i >= 0; i--) {
            for (int j = n-1; j >= 0; j--) {
                if (i == n-1 && j == n-1) continue;
                if (board.get(i).charAt(j) == 'X') {
                    dpSum[i][j] = 0;
                    dpCount[i][j] = 0;
                    continue;
                }
                int max = 0;
                int count = 0;
                int val = (i == 0 && j == 0) ? 0 : (board.get(i).charAt(j) - '0');

                if (i+1 < n && dpCount[i+1][j] > 0) {
                    max = dpSum[i+1][j] + val;
                    count = dpCount[i+1][j];
                }

                if (j+1 < n && dpCount[i][j+1] > 0) {
                    if (dpSum[i][j+1] + val > max) {
                        max = dpSum[i][j+1] + val;
                        count = dpCount[i][j+1];
                    } else if (dpSum[i][j+1] + val == max) {
                        count = (count + dpCount[i][j+1]) % mod;
                    }
                }

                if (i+1 < n && j+1 < n && dpCount[i+1][j+1] > 0) {
                    if (dpSum[i+1][j+1] + val > max) {
                        max = dpSum[i+1][j+1] + val;
                        count = dpCount[i+1][j+1];
                    } else if (dpSum[i+1][j+1] + val == max) {
                        count = (count + dpCount[i+1][j+1]) % mod;
                    }
                }

                dpSum[i][j] = max;
                dpCount[i][j] = count;
            }
        }

        return new int[]{dpSum[0][0], dpCount[0][0]};
    }
}