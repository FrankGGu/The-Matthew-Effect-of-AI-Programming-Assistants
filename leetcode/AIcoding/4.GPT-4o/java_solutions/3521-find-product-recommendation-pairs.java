import java.util.*;

public class Solution {
    public List<List<Integer>> findProductPairs(int[][] products, int target) {
        List<List<Integer>> result = new ArrayList<>();
        Map<Integer, Integer> productMap = new HashMap<>();

        for (int[] product : products) {
            productMap.put(product[0], product[1]);
        }

        for (int[] product : products) {
            int complement = target - product[1];
            if (productMap.containsKey(complement) && productMap.get(complement) != product[1]) {
                List<Integer> pair = Arrays.asList(product[0], productMap.entrySet().stream()
                    .filter(entry -> entry.getValue() == complement)
                    .map(Map.Entry::getKey)
                    .findFirst().orElse(-1));
                Collections.sort(pair);
                if (!result.contains(pair)) {
                    result.add(pair);
                }
            }
        }

        return result;
    }
}