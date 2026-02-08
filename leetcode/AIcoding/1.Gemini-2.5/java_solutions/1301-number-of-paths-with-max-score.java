import java.util.List;

class Solution {
    public int[] pathsWithMaxScore(List<String> board) {
        int m = board.size();
        int n = board.get(0).length();
        int MOD = 1_000_000_007;

        int[][] dp_score = new int[m][n];
        int[][] dp_paths = new int[m][n];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                dp_score[i][j] = Integer.MIN_VALUE / 2; 
                dp_paths[i][j] = 0;
            }
        }

        dp_score[m - 1][n - 1] = 0;
        dp_paths[m - 1][n - 1] = 1;

        for (int i = m - 1; i >= 0; i--) {
            for (int j = n - 1; j >= 0; j--) {
                if (board.get(i).charAt(j) == 'X') {
                    continue;
                }

                if (i == m - 1 && j == n - 1) {
                    continue;
                }

                int currentVal = 0;
                char cellChar = board.get(i).charAt(j);
                if (cellChar != 'S' && cellChar != 'E') {
                    currentVal = cellChar - '0';
                }

                int maxScoreFromNeighbors = Integer.MIN_VALUE / 2;
                int numPathsToCurrent = 0;

                if (i + 1 < m && dp_paths[i + 1][j] > 0) {
                    int score = dp_score[i + 1][j];
                    int paths = dp_paths[i + 1][j];
                    if (score > maxScoreFromNeighbors) {
                        maxScoreFromNeighbors = score;
                        numPathsToCurrent = paths;
                    } else if (score == maxScoreFromNeighbors) {
                        numPathsToCurrent = (numPathsToCurrent + paths) % MOD;
                    }
                }

                if (j + 1 < n && dp_paths[i][j + 1] > 0) {
                    int score = dp_score[i][j + 1];
                    int paths = dp_paths[i][j + 1];
                    if (score > maxScoreFromNeighbors) {
                        maxScoreFromNeighbors = score;
                        numPathsToCurrent = paths;
                    } else if (score == maxScoreFromNeighbors) {
                        numPathsToCurrent = (numPathsToCurrent + paths) % MOD;
                    }
                }

                if (i + 1 < m && j + 1 < n && dp_paths[i + 1][j + 1] > 0) {
                    int score = dp_score[i + 1][j + 1];
                    int paths = dp_paths[i + 1][j + 1];
                    if (score > maxScoreFromNeighbors) {
                        maxScoreFromNeighbors = score;
                        numPathsToCurrent = paths;
                    } else if (score == maxScoreFromNeighbors) {
                        numPathsToCurrent = (numPathsToCurrent + paths) % MOD;
                    }
                }

                if (numPathsToCurrent > 0) {
                    dp_score[i][j] = maxScoreFromNeighbors + currentVal;
                    dp_paths[i][j] = numPathsToCurrent;
                }
            }
        }

        if (dp_paths[0][0] == 0) {
            return new int[]{0, 0};
        } else {
            return new int[]{dp_score[0][0], dp_paths[0][0]};
        }
    }
}