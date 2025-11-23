import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

class Solution {
    public List<List<String>> findRecommendationPairs(List<String> purchases) {
        Map<String, Set<String>> userProductsMap = new HashMap<>();
        for (String purchase : purchases) {
            String[] parts = purchase.split(",");
            String userId = parts[0];
            String productId = parts[1];
            userProductsMap.computeIfAbsent(userId, k -> new HashSet<>()).add(productId);
        }

        Map<String, Integer> pairCounts = new HashMap<>();
        for (Set<String> products : userProductsMap.values()) {
            List<String> productList = new ArrayList<>(products);
            Collections.sort(productList);

            for (int i = 0; i < productList.size(); i++) {
                for (int j = i + 1; j < productList.size(); j++) {
                    String p1 = productList.get(i);
                    String p2 = productList.get(j);
                    String pairKey = p1 + "," + p2;
                    pairCounts.put(pairKey, pairCounts.getOrDefault(pairKey, 0) + 1);
                }
            }
        }

        List<List<String>> result = new ArrayList<>();
        for (Map.Entry<String, Integer> entry : pairCounts.entrySet()) {
            String[] products = entry.getKey().split(",");
            List<String> pairInfo = new ArrayList<>();
            pairInfo.add(products[0]);
            pairInfo.add(products[1]);
            pairInfo.add(String.valueOf(entry.getValue()));
            result.add(pairInfo);
        }

        Collections.sort(result, (a, b) -> {
            int freqA = Integer.parseInt(a.get(2));
            int freqB = Integer.parseInt(b.get(2));
            if (freqA != freqB) {
                return Integer.compare(freqB, freqA);
            }
            int cmp1 = a.get(0).compareTo(b.get(0));
            if (cmp1 != 0) {
                return cmp1;
            }
            return a.get(1).compareTo(b.get(1));
        });

        return result;
    }
}