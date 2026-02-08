import java.util.Arrays;

class Solution {
    public int[] earliestAndLatest(int n, int firstPlayer, int secondPlayer) {
        int[] result = new int[2];
        int[] minMaxRounds = earliestAndLatestHelper(n, firstPlayer, secondPlayer, 1, new int[2][n + 1][n + 1]);
        result[0] = minMaxRounds[0];
        result[1] = minMaxRounds[1];
        return result;
    }

    private int[] earliestAndLatestHelper(int n, int firstPlayer, int secondPlayer, int round, int[][][] memo) {
        if (memo[0][firstPlayer][secondPlayer] != 0) {
            return new int[]{memo[0][firstPlayer][secondPlayer], memo[1][firstPlayer][secondPlayer]};
        }

        if (Math.abs(firstPlayer - secondPlayer) == 1 && (firstPlayer + secondPlayer == n + 1)) {
            memo[0][firstPlayer][secondPlayer] = round;
            memo[1][firstPlayer][secondPlayer] = round;
            return new int[]{round, round};
        }

        int minRounds = Integer.MAX_VALUE;
        int maxRounds = Integer.MIN_VALUE;

        for (int i = 0; i < (1 << (n / 2)); i++) {
            if (Integer.bitCount(i) != (n + 1) / 2) {
                continue;
            }

            int newFirstPlayer = -1;
            int newSecondPlayer = -1;
            int nextPlayer = 1;
            boolean firstPlayerWins = false;
            boolean secondPlayerWins = false;

            for (int j = 0; j < n; j++) {
                if ((i & (1 << (j / 2))) != 0 && j % 2 == 0) {
                    if (j + 1 == firstPlayer) {
                        firstPlayerWins = true;
                        newFirstPlayer = nextPlayer;
                    } else if (j + 1 == secondPlayer) {
                        secondPlayerWins = true;
                        newSecondPlayer = nextPlayer;
                    }
                    nextPlayer++;
                } else if ((i & (1 << (j / 2))) == 0 && j % 2 == 1) {
                    if (j + 1 == firstPlayer) {
                        firstPlayerWins = true;
                        newFirstPlayer = nextPlayer;
                    } else if (j + 1 == secondPlayer) {
                        secondPlayerWins = true;
                        newSecondPlayer = nextPlayer;
                    }
                    nextPlayer++;
                }
            }

            if (newFirstPlayer == -1) {
                newFirstPlayer = (firstPlayerWins) ? newFirstPlayer = nextPlayer : -1;
                for (int j = 1; j <= n; j++) {
                    if ((i & (1 << ((j - 1) / 2))) != 0 && (j - 1) % 2 == 0) {
                        if (j == firstPlayer) {
                           newFirstPlayer = nextPlayer;
                           break;
                        }
                    }
                }
                if (newFirstPlayer == -1) newFirstPlayer = firstPlayerWins ? nextPlayer : -1;

            }

            if (newSecondPlayer == -1) {
                newSecondPlayer = (secondPlayerWins) ? newSecondPlayer = nextPlayer : -1;
                for (int j = 1; j <= n; j++) {
                    if ((i & (1 << ((j - 1) / 2))) != 0 && (j - 1) % 2 == 0) {
                        if (j == secondPlayer) {
                           newSecondPlayer = nextPlayer;
                           break;
                        }
                    }
                }
                if (newSecondPlayer == -1) newSecondPlayer = secondPlayerWins ? nextPlayer : -1;
            }

            if (newFirstPlayer == -1 || newSecondPlayer == -1) continue;
            if (newFirstPlayer > newSecondPlayer) {
                int temp = newFirstPlayer;
                newFirstPlayer = newSecondPlayer;
                newSecondPlayer = temp;
            }

            int newN = (n + 1) / 2;
            int[] subResult = earliestAndLatestHelper(newN, newFirstPlayer, newSecondPlayer, round + 1, memo);
            minRounds = Math.min(minRounds, subResult[0]);
            maxRounds = Math.max(maxRounds, subResult[1]);
        }

        memo[0][firstPlayer][secondPlayer] = minRounds;
        memo[1][firstPlayer][secondPlayer] = maxRounds;

        return new int[]{minRounds, maxRounds};
    }
}