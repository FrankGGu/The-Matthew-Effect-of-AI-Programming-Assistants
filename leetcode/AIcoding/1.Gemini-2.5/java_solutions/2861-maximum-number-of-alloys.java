import java.util.List;

class Solution {
    public long maxNumberOfAlloys(int n, int k, long budget, List<List<Integer>> composition, List<Integer> stock, List<Integer> cost) {
        long low = 0;
        // A rough upper bound for the number of alloys.
        // If composition[j][i] = 1, stock[i] = 10^9, budget = 10^9, cost[i] = 1.
        // We can make up to 2 * 10^9 alloys (10^9 from stock, 10^9 from budget).
        // So, 2 * 10^9 is a reasonable upper bound. Adding a small constant for safety.
        long high = 2_000_000_000L + 7; 
        long ans = 0;

        while (low <= high) {
            long mid = low + (high - low) / 2;
            if (canMake(mid, n, k, budget, composition, stock, cost)) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return ans;
    }

    private boolean canMake(long numAlloys, int n, int k, long budget, List<List<Integer>> composition, List<Integer> stock, List<Integer> cost) {
        if (numAlloys == 0) {
            return true;
        }

        for (int i = 0; i < k; i++) { // Iterate through each factory
            long currentFactoryCost = 0;

            for (int j = 0; j < n; j++) { // Iterate through each metal type
                long neededMetal = (long) composition.get(i).get(j) * numAlloys;
                long toBuy = Math.max(0L, neededMetal - stock.get(j));

                long metalCost;
                if (toBuy == 0 || cost.get(j) == 0) {
                    metalCost = 0;
                } else {
                    // Check if toBuy * cost.get(j) would exceed the total budget.
                    // If 'toBuy' is greater than 'budget / cost.get(j)', then 'toBuy * cost.get(j)'
                    // would definitely be greater than 'budget'.
                    // This comparison is safe because 'budget / cost.get(j)' is at most 10^9 (budget/1),
                    // and 'toBuy' can be up to ~2*10^18. Both fit in 'long'.
                    if (toBuy > budget / cost.get(j)) { 
                        // If the cost for this single metal type already exceeds the total budget,
                        // then this factory definitely cannot make the alloys.
                        // Set metalCost to a value that ensures currentFactoryCost exceeds budget.
                        metalCost = budget + 1; 
                    } else {
                        // The product toBuy * cost.get(j) will not exceed budget, so it fits in long.
                        metalCost = toBuy * cost.get(j);
                    }
                }

                currentFactoryCost += metalCost;
                if (currentFactoryCost > budget) {
                    // This factory cannot make numAlloys within budget. Move to the next factory.
                    break; 
                }
            }

            if (currentFactoryCost <= budget) {
                return true; // This factory can make numAlloys within budget.
            }
        }
        return false; // No factory can make numAlloys within budget.
    }
}