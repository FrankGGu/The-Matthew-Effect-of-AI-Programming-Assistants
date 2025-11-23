class Solution {
    private static final int MOD = 1000000007;

    public int colorTheGrid(int m, int n) {
        int totalStates = (int) Math.pow(3, m);
        int[][] dp = new int[n][totalStates];

        for (int state = 0; state < totalStates; state++) {
            if (isValidState(state, m)) {
                dp[0][state] = 1;
            }
        }

        for (int col = 1; col < n; col++) {
            for (int prevState = 0; prevState < totalStates; prevState++) {
                if (dp[col - 1][prevState] == 0) continue;
                for (int currState = 0; currState < totalStates; currState++) {
                    if (isValidState(currState, m) {
                        if (checkAdjacent(prevState, currState, m)) {
                            dp[col][currState] = (dp[col][currState] + dp[col - 1][prevState]) % MOD;
                        }
                    }
                }
            }
        }

        int result = 0;
        for (int state = 0; state < totalStates; state++) {
            result = (result + dp[n - 1][state]) % MOD;
        }
        return result;
    }

    private boolean isValidState(int state, int m) {
        int prevColor = -1;
        for (int i = 0; i < m; i++) {
            int color = state % 3;
            state /= 3;
            if (color == prevColor) {
                return false;
            }
            prevColor = color;
        }
        return true;
    }

    private boolean checkAdjacent(int prevState, int currState, int m) {
        for (int i = 0; i < m; i++) {
            int prevColor = prevState % 3;
            int currColor = currState % 3;
            if (prevColor == currColor) {
                return false;
            }
            prevState /= 3;
            currState /= 3;
        }
        return true;
    }
}