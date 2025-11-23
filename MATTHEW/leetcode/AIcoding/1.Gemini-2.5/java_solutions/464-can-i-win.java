import java.util.HashMap;
import java.util.Map;

class Solution {
    int maxChoosableInteger;
    int desiredTotal;
    Map<Integer, Boolean> memo;

    public boolean canIWin(int maxChoosableInteger, int desiredTotal) {
        if (desiredTotal <= 0) {
            return true;
        }

        int sumOfAllNumbers = maxChoosableInteger * (maxChoosableInteger + 1) / 2;
        if (sumOfAllNumbers < desiredTotal) {
            return false;
        }

        this.maxChoosableInteger = maxChoosableInteger;
        this.desiredTotal = desiredTotal;
        this.memo = new HashMap<>();

        return canWin(0, 0);
    }

    private boolean canWin(int mask, int currentTotal) {
        if (currentTotal >= desiredTotal) {
            return false;
        }

        if (memo.containsKey(mask)) {
            return memo.get(mask);
        }

        for (int i = 1; i <= maxChoosableInteger; i++) {
            if ((mask & (1 << (i - 1))) == 0) {
                int newMask = mask | (1 << (i - 1));
                int newTotal = currentTotal + i;

                if (!canWin(newMask, newTotal)) {
                    memo.put(mask, true);
                    return true;
                }
            }
        }

        memo.put(mask, false);
        return false;
    }
}