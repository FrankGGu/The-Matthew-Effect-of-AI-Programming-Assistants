import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int leastOperators(int x, int target) {
        Map<Integer, Integer> memo = new HashMap<>();
        return dfs(x, target, memo);
    }

    private int dfs(int x, int target, Map<Integer, Integer> memo) {
        if (target < 1) return Integer.MAX_VALUE;
        if (target == 1) return 0;
        if (memo.containsKey(target)) return memo.get(target);

        int minOps = Integer.MAX_VALUE;
        for (int i = 1; i <= target; i *= x) {
            int ops = 1 + dfs(x, target - i, memo);
            minOps = Math.min(minOps, ops);
        }

        memo.put(target, minOps);
        return minOps;
    }
}