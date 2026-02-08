class Solution {
    public int[] pathsWithMaxScore(List<String> board) {
        int n = board.size();
        int MOD = 1000000007;
        int[][] dpScore = new int[n][n];
        int[][] dpPaths = new int[n][n];

        dpScore[n - 1][n - 1] = 0;
        dpPaths[n - 1][n - 1] = 1;

        for (int i = n - 1; i >= 0; i--) {
            for (int j = n - 1; j >= 0; j--) {
                if (board.get(i).charAt(j) == 'X') {
                    dpPaths[i][j] = 0;
                    continue;
                }

                if (i == n - 1 && j == n - 1) {
                    continue;
                }

                int score = (board.get(i).charAt(j) == 'S' ? 0 : board.get(i).charAt(j) - '0');
                int maxScore = -1;
                int paths = 0;

                if (i + 1 < n && dpPaths[i + 1][j] > 0) {
                    if (dpScore[i + 1][j] > maxScore) {
                        maxScore = dpScore[i + 1][j];
                        paths = dpPaths[i + 1][j];
                    } else if (dpScore[i + 1][j] == maxScore) {
                        paths = (paths + dpPaths[i + 1][j]) % MOD;
                    }
                }

                if (j + 1 < n && dpPaths[i][j + 1] > 0) {
                    if (dpScore[i][j + 1] > maxScore) {
                        maxScore = dpScore[i][j + 1];
                        paths = dpPaths[i][j + 1];
                    } else if (dpScore[i][j + 1] == maxScore) {
                        paths = (paths + dpPaths[i][j + 1]) % MOD;
                    }
                }

                if (i + 1 < n && j + 1 < n && dpPaths[i + 1][j + 1] > 0) {
                    if (dpScore[i + 1][j + 1] > maxScore) {
                        maxScore = dpScore[i + 1][j + 1];
                        paths = dpPaths[i + 1][j + 1];
                    } else if (dpScore[i + 1][j + 1] == maxScore) {
                        paths = (paths + dpPaths[i + 1][j + 1]) % MOD;
                    }
                }

                if (maxScore != -1) {
                    dpScore[i][j] = maxScore + score;
                    dpPaths[i][j] = paths;
                }
            }
        }

        return new int[]{dpScore[0][0], dpPaths[0][0]};
    }
}