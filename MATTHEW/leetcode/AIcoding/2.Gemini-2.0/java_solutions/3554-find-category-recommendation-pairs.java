import java.util.*;

class Solution {
    public List<List<String>> findCategoryRecommendationPairs(List<List<String>> input) {
        Map<String, Set<String>> categoryToProducts = new HashMap<>();
        for (List<String> pair : input) {
            String product = pair.get(0);
            String category = pair.get(1);
            categoryToProducts.computeIfAbsent(category, k -> new HashSet<>()).add(product);
        }

        List<List<String>> result = new ArrayList<>();
        List<String> categories = new ArrayList<>(categoryToProducts.keySet());
        Collections.sort(categories);

        for (int i = 0; i < categories.size(); i++) {
            for (int j = i + 1; j < categories.size(); j++) {
                String cat1 = categories.get(i);
                String cat2 = categories.get(j);
                Set<String> products1 = categoryToProducts.get(cat1);
                Set<String> products2 = categoryToProducts.get(cat2);

                Set<String> intersection = new HashSet<>(products1);
                intersection.retainAll(products2);

                if (!intersection.isEmpty()) {
                    result.add(Arrays.asList(cat1, cat2));
                }
            }
        }

        return result;
    }
}