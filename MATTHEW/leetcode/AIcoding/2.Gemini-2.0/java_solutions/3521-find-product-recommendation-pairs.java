import java.util.*;

class Solution {
    public List<List<String>> findProductPairs(List<List<String>> orders) {
        Map<String, Set<Integer>> productToOrders = new HashMap<>();
        for (int i = 0; i < orders.size(); i++) {
            for (String product : orders.get(i)) {
                productToOrders.computeIfAbsent(product, k -> new HashSet<>()).add(i);
            }
        }

        Set<List<String>> pairs = new HashSet<>();
        for (String product1 : productToOrders.keySet()) {
            for (String product2 : productToOrders.keySet()) {
                if (product1.compareTo(product2) >= 0) continue;

                Set<Integer> orders1 = productToOrders.get(product1);
                Set<Integer> orders2 = productToOrders.get(product2);

                Set<Integer> intersection = new HashSet<>(orders1);
                intersection.retainAll(orders2);

                if (intersection.size() >= 2) {
                    List<String> pair = Arrays.asList(product1, product2);
                    pairs.add(pair);
                }
            }
        }

        List<List<String>> result = new ArrayList<>(pairs);
        Collections.sort(result, (a, b) -> {
            int compare1 = a.get(0).compareTo(b.get(0));
            if (compare1 != 0) return compare1;
            return a.get(1).compareTo(b.get(1));
        });

        return result;
    }
}