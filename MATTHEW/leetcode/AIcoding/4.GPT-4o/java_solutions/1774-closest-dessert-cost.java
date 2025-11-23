import java.util.List;

public class Solution {
    public int closestCost(List<Integer> baseCosts, int[] toppingCosts, int target) {
        int closest = Integer.MAX_VALUE;
        int minDiff = Integer.MAX_VALUE;

        for (int base : baseCosts) {
            dfs(base, toppingCosts, 0, target, closest, minDiff);
        }

        return closest;
    }

    private void dfs(int currentCost, int[] toppingCosts, int index, int target, int closest, int minDiff) {
        int diff = Math.abs(currentCost - target);

        if (diff < minDiff || (diff == minDiff && currentCost < closest)) {
            closest = currentCost;
            minDiff = diff;
        }

        if (index == toppingCosts.length) {
            return;
        }

        dfs(currentCost, toppingCosts, index + 1, target, closest, minDiff);
        dfs(currentCost + toppingCosts[index], toppingCosts, index + 1, target, closest, minDiff);
        dfs(currentCost + toppingCosts[index] * 2, toppingCosts, index + 1, target, closest, minDiff);
    }
}