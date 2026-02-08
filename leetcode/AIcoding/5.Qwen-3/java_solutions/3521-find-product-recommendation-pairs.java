public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> findProductRecommendationPairs(int[][] reviews) {
        Map<Integer, Set<Integer>> productMap = new HashMap<>();

        for (int[] review : reviews) {
            int productId = review[0];
            int[] products = review[1];

            for (int product : products) {
                productMap.putIfAbsent(productId, new HashSet<>());
                productMap.get(productId).add(product);
            }
        }

        List<List<Integer>> result = new ArrayList<>();

        for (Map.Entry<Integer, Set<Integer>> entry1 : productMap.entrySet()) {
            int productId1 = entry1.getKey();
            Set<Integer> products1 = entry1.getValue();

            for (Map.Entry<Integer, Set<Integer>> entry2 : productMap.entrySet()) {
                int productId2 = entry2.getKey();
                Set<Integer> products2 = entry2.getValue();

                if (productId1 >= productId2) continue;

                Set<Integer> commonProducts = new HashSet<>(products1);
                commonProducts.retainAll(products2);

                if (!commonProducts.isEmpty()) {
                    result.add(Arrays.asList(productId1, productId2));
                }
            }
        }

        return result;
    }
}
}