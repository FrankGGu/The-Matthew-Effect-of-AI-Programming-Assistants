public class Solution {

import java.util.*;

public class Solution {
    public int closestCost(int[] baseCosts, int[] toppingCosts, int target) {
        Set<Integer> set = new HashSet<>();
        for (int cost : baseCosts) {
            set.add(cost);
        }
        dfs(0, 0, toppingCosts, set);
        int closest = Integer.MAX_VALUE;
        for (int cost : set) {
            if (Math.abs(cost - target) < Math.abs(closest - target)) {
                closest = cost;
            } else if (Math.abs(cost - target) == Math.abs(closest - target) && cost < closest) {
                closest = cost;
            }
        }
        return closest;
    }

    private void dfs(int index, int current, int[] toppingCosts, Set<Integer> set) {
        if (index == toppingCosts.length) {
            set.add(current);
            return;
        }
        dfs(index + 1, current, toppingCosts, set);
        dfs(index + 1, current + toppingCosts[index], toppingCosts, set);
        dfs(index + 1, current + 2 * toppingCosts[index], toppingCosts, set);
    }
}
}