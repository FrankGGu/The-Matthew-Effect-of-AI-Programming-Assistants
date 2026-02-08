public class Solution {

import java.util.*;

public class Solution {
    public int maxAmount(int[] coins, int[][] convert) {
        Map<Integer, List<int[]>> graph = new HashMap<>();
        for (int[] c : convert) {
            graph.putIfAbsent(c[0], new ArrayList<>());
            graph.get(c[0]).add(new int[]{c[1], c[2]});
        }

        int[] dp = new int[coins.length];
        for (int i = 0; i < coins.length; i++) {
            dp[i] = coins[i];
        }

        for (int day = 0; day < 2; day++) {
            int[] nextDp = Arrays.copyOf(dp, dp.length);
            for (int coin : graph.keySet()) {
                for (int[] neighbor : graph.get(coin)) {
                    int toCoin = neighbor[0];
                    int rate = neighbor[1];
                    nextDp[toCoin] = Math.max(nextDp[toCoin], dp[coin] * rate);
                }
            }
            dp = nextDp;
        }

        int max = 0;
        for (int val : dp) {
            max = Math.max(max, val);
        }
        return max;
    }
}
}