class Solution {
    int minDiff;
    int closestCost;
    int target;
    int[] toppingCosts;

    public int closestCost(int[] baseCosts, int[] toppingCosts, int target) {
        this.minDiff = Integer.MAX_VALUE;
        this.closestCost = Integer.MAX_VALUE;
        this.target = target;
        this.toppingCosts = toppingCosts;

        for (int baseCost : baseCosts) {
            dfs(0, baseCost);
        }

        return closestCost;
    }

    private void dfs(int toppingIndex, int currentCost) {
        if (currentCost > target + minDiff) {
            return;
        }

        if (toppingIndex == toppingCosts.length) {
            int diff = Math.abs(currentCost - target);
            if (diff < minDiff) {
                minDiff = diff;
                closestCost = currentCost;
            } else if (diff == minDiff) {
                closestCost = Math.min(closestCost, currentCost);
            }
            return;
        }

        dfs(toppingIndex + 1, currentCost);

        dfs(toppingIndex + 1, currentCost + toppingCosts[toppingIndex]);

        dfs(toppingIndex + 1, currentCost + 2 * toppingCosts[toppingIndex]);
    }
}