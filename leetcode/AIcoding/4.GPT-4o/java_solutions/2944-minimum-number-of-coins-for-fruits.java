import java.util.HashMap;
import java.util.Map;

class Solution {
    public int minCoins(String[] fruits, int[] cost, int target) {
        Map<String, Integer> fruitCost = new HashMap<>();
        for (int i = 0; i < fruits.length; i++) {
            fruitCost.put(fruits[i], cost[i]);
        }

        int[] dp = new int[target + 1];
        for (int i = 1; i <= target; i++) {
            dp[i] = Integer.MAX_VALUE;
            for (String fruit : fruits) {
                if (i >= fruitCost.get(fruit)) {
                    dp[i] = Math.min(dp[i], dp[i - fruitCost.get(fruit)] + 1);
                }
            }
        }
        return dp[target] == Integer.MAX_VALUE ? -1 : dp[target];
    }
}