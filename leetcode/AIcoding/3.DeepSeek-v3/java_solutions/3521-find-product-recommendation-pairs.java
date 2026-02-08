import java.util.*;

class Solution {
    public List<List<Integer>> findProductPairs(int[] products, int target) {
        List<List<Integer>> result = new ArrayList<>();
        Set<Integer> seen = new HashSet<>();
        for (int i = 0; i < products.length; i++) {
            if (target % products[i] == 0) {
                int complement = target / products[i];
                if (seen.contains(complement)) {
                    List<Integer> pair = new ArrayList<>();
                    pair.add(complement);
                    pair.add(products[i]);
                    result.add(pair);
                }
            }
            seen.add(products[i]);
        }
        return result;
    }
}