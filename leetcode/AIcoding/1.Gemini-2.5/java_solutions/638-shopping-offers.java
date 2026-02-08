import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    private Map<List<Integer>, Integer> memo;
    private List<Integer> price;
    private List<List<Integer>> special;
    private int numItems;

    public int shoppingOffers(List<Integer> price, List<List<Integer>> special, List<Integer> needs) {
        this.price = price;
        this.numItems = price.size();
        this.memo = new HashMap<>();

        // Filter out offers that are more expensive than buying the items individually.
        // This can reduce the number of offers to consider, potentially improving performance.
        List<List<Integer>> filteredSpecial = new ArrayList<>();
        for (List<Integer> offer : special) {
            int offerPrice = offer.get(numItems);
            int individualCostForOffer = 0;
            for (int i = 0; i < numItems; i++) {
                individualCostForOffer += offer.get(i) * price.get(i);
            }
            // Only consider offers that are cheaper than buying the items individually.
            // If an offer costs the same or more, it's never strictly better to take it
            // as we can achieve the same or lower cost by buying individually.
            if (offerPrice < individualCostForOffer) {
                filteredSpecial.add(offer);
            }
        }
        this.special = filteredSpecial;

        return dfs(needs);
    }

    private int dfs(List<Integer> currentNeeds) {
        if (memo.containsKey(currentNeeds)) {
            return memo.get(currentNeeds);
        }

        // Option 1: Calculate cost by buying all remaining items individually
        int minCost = 0;
        for (int i = 0; i < numItems; i++) {
            minCost += currentNeeds.get(i) * price.get(i);
        }

        // Option 2: Try to apply special offers
        for (List<Integer> offer : special) {
            List<Integer> nextNeeds = new ArrayList<>(numItems);
            boolean canApply = true;
            for (int i = 0; i < numItems; i++) {
                int remaining = currentNeeds.get(i) - offer.get(i);
                if (remaining < 0) { // Not enough items in currentNeeds to take this offer
                    canApply = false;
                    break;
                }
                nextNeeds.add(remaining);
            }

            if (canApply) {
                // If the offer can be applied, calculate the cost and update minCost
                minCost = Math.min(minCost, offer.get(numItems) + dfs(nextNeeds));
            }
        }

        memo.put(currentNeeds, minCost);
        return minCost;
    }
}