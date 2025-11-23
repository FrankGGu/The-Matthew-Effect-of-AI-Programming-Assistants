public class Solution {

import java.util.*;

public class Solution {
    public int[] earliestAndLatest(int n, int firstPlayer, int secondPlayer) {
        Map<String, int[]> memo = new HashMap<>();
        return dfs(1, n, firstPlayer, secondPlayer, memo);
    }

    private int[] dfs(int round, int n, int first, int second, Map<String, int[]> memo) {
        String key = round + "," + first + "," + second;
        if (memo.containsKey(key)) {
            return memo.get(key);
        }
        if (first == second) {
            return new int[]{round, round};
        }
        int minRound = Integer.MAX_VALUE;
        int maxRound = Integer.MIN_VALUE;
        for (int i = 1; i <= n; i++) {
            if (i == first || i == second) continue;
            int nextFirst = i < first ? i : first;
            int nextSecond = i < second ? i : second;
            int[] res = dfs(round + 1, n, nextFirst, nextSecond, memo);
            minRound = Math.min(minRound, res[0]);
            maxRound = Math.max(maxRound, res[1]);
        }
        int[] result = new int[]{minRound, maxRound};
        memo.put(key, result);
        return result;
    }
}
}