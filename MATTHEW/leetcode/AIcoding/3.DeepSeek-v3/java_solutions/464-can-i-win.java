class Solution {
    public boolean canIWin(int maxChoosableInteger, int desiredTotal) {
        if (desiredTotal <= 0) return true;
        if (maxChoosableInteger * (maxChoosableInteger + 1) / 2 < desiredTotal) return false;
        Boolean[] memo = new Boolean[1 << maxChoosableInteger];
        return canWin(maxChoosableInteger, desiredTotal, 0, memo);
    }

    private boolean canWin(int n, int total, int state, Boolean[] memo) {
        if (total <= 0) return false;
        if (memo[state] != null) return memo[state];
        for (int i = 0; i < n; i++) {
            if ((state & (1 << i)) == 0) {
                if (!canWin(n, total - (i + 1), state | (1 << i), memo)) {
                    memo[state] = true;
                    return true;
                }
            }
        }
        memo[state] = false;
        return false;
    }
}