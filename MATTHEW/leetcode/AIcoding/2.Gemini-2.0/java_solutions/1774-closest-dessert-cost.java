class Solution {
    private int target;
    private int minDiff = Integer.MAX_VALUE;
    private int result;

    public int closestCost(int[] baseCosts, int[] toppingCosts, int target) {
        this.target = target;
        for (int baseCost : baseCosts) {
            backtrack(toppingCosts, 0, baseCost);
        }
        return result;
    }

    private void backtrack(int[] toppingCosts, int index, int currentCost) {
        int diff = Math.abs(currentCost - target);
        if (diff < minDiff) {
            minDiff = diff;
            result = currentCost;
        } else if (diff == minDiff) {
            result = Math.min(result, currentCost);
        }

        if (index == toppingCosts.length) {
            return;
        }

        backtrack(toppingCosts, index + 1, currentCost);
        backtrack(toppingCosts, index + 1, currentCost + toppingCosts[index]);
        backtrack(toppingCosts, index + 1, currentCost + 2 * toppingCosts[index]);
    }
}