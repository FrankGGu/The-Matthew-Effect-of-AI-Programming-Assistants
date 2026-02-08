public class Solution {

import java.util.*;

public class Solution {
    public int leastOperators(int target, int k) {
        Map<Integer, Integer> memo = new HashMap<>();
        return dfs(target, k, memo);
    }

    private int dfs(int target, int k, Map<Integer, Integer> memo) {
        if (target == 0) return 0;
        if (memo.containsKey(target)) return memo.get(target);

        int res = Integer.MAX_VALUE;
        int i = 1;
        int val = k;

        while (val < target) {
            val *= k;
            i++;
        }

        if (val == target) {
            res = i - 1;
        } else {
            res = dfs(val - target, k, memo) + i;
            if (val - target < target) {
                res = Math.min(res, dfs(target - val / k, k, memo) + i - 1);
            }
        }

        memo.put(target, res);
        return res;
    }
}
}