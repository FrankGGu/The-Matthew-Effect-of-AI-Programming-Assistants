class Solution {
    public int knightDialer(int N) {
        int mod = 1000000007;
        long[][] dp = new long[4][3];
        dp[3][1] = 1; // start from 5

        int[][] moves = {
            {4, 6}, 
            {6, 8}, 
            {7, 9}, 
            {4, 8}, 
            {}, 
            {}, 
            {1, 7, 0}, 
            {2, 6}, 
            {1, 3}, 
            {2, 4}
        };

        for (int i = 1; i < N; i++) {
            long[][] newDp = new long[4][3];
            for (int r = 0; r < 4; r++) {
                for (int c = 0; c < 3; c++) {
                    for (int move : moves[r * 3 + c]) {
                        newDp[r][c] = (newDp[r][c] + dp[move / 3][move % 3]) % mod;
                    }
                }
            }
            dp = newDp;
        }

        long result = 0;
        for (int r = 0; r < 4; r++) {
            for (int c = 0; c < 3; c++) {
                result = (result + dp[r][c]) % mod;
            }
        }
        return (int) result;
    }
}