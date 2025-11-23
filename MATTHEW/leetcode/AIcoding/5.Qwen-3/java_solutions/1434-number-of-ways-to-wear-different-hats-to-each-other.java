public class Solution {

import java.util.*;

public class Solution {
    public int numberWays(List<List<Integer>> hats) {
        int n = hats.size();
        Map<Integer, List<Integer>> hatToPeople = new HashMap<>();
        for (int i = 0; i < n; i++) {
            for (int h : hats.get(i)) {
                hatToPeople.putIfAbsent(h, new ArrayList<>());
                hatToPeople.get(h).add(i);
            }
        }

        int[] dp = new int[1 << n];
        dp[0] = 1;

        for (int h = 1; h <= 100; h++) {
            if (!hatToPeople.containsKey(h)) continue;
            List<Integer> people = new ArrayList<>(hatToPeople.get(h));
            int[] newDp = Arrays.copyOf(dp, dp.length);
            for (int mask = 0; mask < (1 << n); mask++) {
                if (dp[mask] == 0) continue;
                for (int p : people) {
                    if ((mask & (1 << p)) == 0) {
                        newDp[mask | (1 << p)] += dp[mask];
                    }
                }
            }
            dp = newDp;
        }

        return dp[(1 << n) - 1];
    }
}
}