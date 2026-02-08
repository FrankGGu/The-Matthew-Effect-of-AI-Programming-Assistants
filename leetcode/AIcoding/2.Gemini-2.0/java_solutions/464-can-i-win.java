public class Solution {
    public boolean canIWin(int maxChoosableInteger, int desiredTotal) {
        if (desiredTotal <= 0) {
            return true;
        }
        if (maxChoosableInteger * (maxChoosableInteger + 1) / 2 < desiredTotal) {
            return false;
        }

        Boolean[] memo = new Boolean[1 << maxChoosableInteger];
        return canWinHelper(maxChoosableInteger, desiredTotal, 0, memo);
    }

    private boolean canWinHelper(int maxChoosableInteger, int desiredTotal, int usedNumbers, Boolean[] memo) {
        if (memo[usedNumbers] != null) {
            return memo[usedNumbers];
        }

        for (int i = 1; i <= maxChoosableInteger; i++) {
            if ((usedNumbers & (1 << (i - 1))) == 0) {
                if (desiredTotal <= i || !canWinHelper(maxChoosableInteger, desiredTotal - i, usedNumbers | (1 << (i - 1)), memo)) {
                    memo[usedNumbers] = true;
                    return true;
                }
            }
        }

        memo[usedNumbers] = false;
        return false;
    }
}