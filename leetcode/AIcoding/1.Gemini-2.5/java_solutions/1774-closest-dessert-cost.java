class Solution {
    private int minDiff;
    private int resultCost;

    public int closestDessertCost(int[] baseCosts, int[] toppingCosts, int target) {
        minDiff = Integer.MAX_VALUE;
        resultCost = 0; 

        for (int baseCost : baseCosts) {
            findToppingCombinations(toppingCosts, 0, baseCost, target);
        }

        return resultCost;
    }

    private void findToppingCombinations(int[] toppingCosts, int index, int currentCost, int target) {
        int currentDiff = Math.abs(currentCost - target);

        if (currentDiff < minDiff) {
            minDiff = currentDiff;
            resultCost = currentCost;
        } else if (currentDiff == minDiff) {
            resultCost = Math.min(resultCost, currentCost);
        }

        if (index == toppingCosts.length) {
            return;
        }

        findToppingCombinations(toppingCosts, index + 1, currentCost, target);
        findToppingCombinations(toppingCosts, index + 1, currentCost + toppingCosts[index], target);
        findToppingCombinations(toppingCosts, index + 1, currentCost + 2 * toppingCosts[index], target);
    }
}