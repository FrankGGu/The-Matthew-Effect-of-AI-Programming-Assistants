class Solution {
    private int closestCost = Integer.MAX_VALUE;
    private int minDiff = Integer.MAX_VALUE;

    public int closestCost(int[] baseCosts, int[] toppingCosts, int target) {
        for (int base : baseCosts) {
            backtrack(toppingCosts, 0, base, target);
        }
        return closestCost;
    }

    private void backtrack(int[] toppingCosts, int index, int currentCost, int target) {
        int currentDiff = Math.abs(currentCost - target);
        if (currentDiff < minDiff || (currentDiff == minDiff && currentCost < closestCost)) {
            minDiff = currentDiff;
            closestCost = currentCost;
        }
        if (index == toppingCosts.length || currentCost >= target) {
            return;
        }
        for (int i = 0; i <= 2; i++) {
            backtrack(toppingCosts, index + 1, currentCost + i * toppingCosts[index], target);
        }
    }
}