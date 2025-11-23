public class Solution {

import java.util.*;

public class Solution {
    public int shoppingOffers(List<Integer> price, List<List<Integer>> special, List<Integer> needs) {
        return dfs(price, special, needs, new HashMap<>());
    }

    private int dfs(List<Integer> price, List<List<Integer>> special, List<Integer> needs, Map<String, Integer> memo) {
        String key = needs.toString();
        if (memo.containsKey(key)) {
            return memo.get(key);
        }

        int cost = 0;
        for (int i = 0; i < price.size(); i++) {
            cost += price.get(i) * needs.get(i);
        }

        for (List<Integer> offer : special) {
            boolean valid = true;
            for (int i = 0; i < needs.size(); i++) {
                if (needs.get(i) < offer.get(i)) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                List<Integer> newNeeds = new ArrayList<>();
                for (int i = 0; i < needs.size(); i++) {
                    newNeeds.add(needs.get(i) - offer.get(i));
                }
                int offerCost = offer.get(offer.size() - 1) + dfs(price, special, newNeeds, memo);
                cost = Math.min(cost, offerCost);
            }
        }

        memo.put(key, cost);
        return cost;
    }
}
}