class Solution {
    public int shoppingOffers(List<Integer> price, List<List<Integer>> special, List<Integer> needs) {
        return dfs(price, special, needs, new HashMap<>());
    }

    private int dfs(List<Integer> price, List<List<Integer>> special, List<Integer> needs, Map<String, Integer> memo) {
        String key = needs.toString();
        if (memo.containsKey(key)) {
            return memo.get(key);
        }

        int minCost = 0;
        for (int i = 0; i < needs.size(); i++) {
            minCost += needs.get(i) * price.get(i);
        }

        for (List<Integer> offer : special) {
            List<Integer> tempNeeds = new ArrayList<>(needs);
            boolean isValid = true;
            for (int i = 0; i < tempNeeds.size(); i++) {
                if (tempNeeds.get(i) < offer.get(i)) {
                    isValid = false;
                    break;
                }
                tempNeeds.set(i, tempNeeds.get(i) - offer.get(i));
            }
            if (isValid) {
                minCost = Math.min(minCost, offer.get(offer.size() - 1) + dfs(price, special, tempNeeds, memo));
            }
        }

        memo.put(key, minCost);
        return minCost;
    }
}