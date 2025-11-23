import java.util.List;

class Solution {
    public int shoppingOffers(List<Integer> price, List<List<Integer>> special, List<Integer> needs) {
        return dfs(price, special, needs);
    }

    private int dfs(List<Integer> price, List<List<Integer>> special, List<Integer> needs) {
        int minCost = 0;
        for (int i = 0; i < needs.size(); i++) {
            minCost += needs.get(i) * price.get(i);
        }

        for (List<Integer> offer : special) {
            List<Integer> newNeeds = new ArrayList<>(needs);
            boolean valid = true;
            for (int i = 0; i < needs.size(); i++) {
                if (newNeeds.get(i) < offer.get(i)) {
                    valid = false;
                    break;
                }
                newNeeds.set(i, newNeeds.get(i) - offer.get(i));
            }
            if (valid) {
                minCost = Math.min(minCost, offer.get(offer.size() - 1) + dfs(price, special, newNeeds));
            }
        }

        return minCost;
    }
}