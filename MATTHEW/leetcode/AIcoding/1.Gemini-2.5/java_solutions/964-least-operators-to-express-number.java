import java.util.HashMap;
import java.util.Map;

class Solution {
    private Map<Long, Integer> memo;
    private int X_val;

    public int leastOpsExpressTarget(int x, int target) {
        X_val = x;
        memo = new HashMap<>();
        return dfs(target);
    }

    private int dfs(long target) {
        if (target == 0) {
            return 0;
        }
        if (target == 1) {
            return 2; // Express 1 as x / x (2 operators: one x, then /, then another x)
        }
        if (memo.containsKey(target)) {
            return memo.get(target);
        }

        long currentPower = X_val;
        int k_ops = 1; // x^1 costs 1 operator (one 'x')

        // Find k such that X_val^k is the smallest power of X_val greater than or equal to target.
        // currentPower will hold X_val^k, and k_ops will hold k.
        while (currentPower < target) {
            // Check for potential overflow before multiplication.
            // For target up to 10^9 and X_val up to 100, currentPower * X_val will not overflow long.
            // E.g., max currentPower before loop breaks is ~10^9. Next power is ~10^11. Long.MAX_VALUE is ~9*10^18.
            if (currentPower > Long.MAX_VALUE / X_val) {
                break; // Prevent overflow for currentPower * X_val
            }
            currentPower *= X_val;
            k_ops++;
        }

        int res;
        if (currentPower == target) {
            res = k_ops;
        } else {
            // Option 1: Express target as currentPower - (currentPower - target)
            // currentPower is X_val^k_ops, which is the smallest power >= target.
            // Cost: k_ops operators for currentPower, plus operators for (currentPower - target).
            res = k_ops + dfs(currentPower - target);

            // Option 2: Express target as (currentPower / X_val) + (target - (currentPower / X_val))
            // (currentPower / X_val) is X_val^(k_ops - 1).
            // This option is valid if k_ops > 1 (i.e., currentPower is not X_val^0 or X_val^1 for target < X_val).
            if (k_ops > 1) {
                long prevPower = currentPower / X_val;
                int prevKOps = k_ops - 1;
                // Cost: prevKOps operators for prevPower, plus operators for (target - prevPower).
                res = Math.min(res, prevKOps + dfs(target - prevPower));
            } else { // k_ops == 1, meaning currentPower is X_val.
                     // In this case, prevPower would be 1 (X_val^0).
                     // target is between 1 and X_val (exclusive of X_val, as currentPower != target).
                     // We need to express target as 1 + (target - 1).
                     // Cost for 1 is 2 (from x/x).
                res = Math.min(res, 2 + dfs(target - 1));
            }
        }

        memo.put(target, res);
        return res;
    }
}