public class Solution {
    public boolean canIWin(int maxChoosableInteger, int desiredTotal) {
        if (desiredTotal <= 0) return true;
        if (maxChoosableInteger * (maxChoosableInteger + 1) / 2 < desiredTotal) return false;

        Boolean[] dp = new Boolean[1 << maxChoosableInteger];
        return canWin(dp, maxChoosableInteger, desiredTotal, 0);
    }

    private boolean canWin(Boolean[] dp, int maxChoosableInteger, int desiredTotal, int used) {
        if (dp[used] != null) return dp[used];

        for (int i = 0; i < maxChoosableInteger; i++) {
            if ((used & (1 << i)) == 0) {
                if (i + 1 >= desiredTotal || !canWin(dp, maxChoosableInteger, desiredTotal - (i + 1), used | (1 << i))) {
                    dp[used] = true;
                    return true;
                }
            }
        }

        dp[used] = false;
        return false;
    }
}