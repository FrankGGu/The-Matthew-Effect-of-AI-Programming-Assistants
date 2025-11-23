public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> findCategoryRecommendationPairs(int[] categoryId, int[] itemId) {
        Map<Integer, List<Integer>> categoryToItems = new HashMap<>();
        for (int i = 0; i < categoryId.length; i++) {
            categoryToItems.computeIfAbsent(categoryId[i], k -> new ArrayList<>()).add(itemId[i]);
        }

        List<List<Integer>> result = new ArrayList<>();

        for (Map.Entry<Integer, List<Integer>> entry1 : categoryToItems.entrySet()) {
            List<Integer> items1 = entry1.getValue();
            for (Map.Entry<Integer, List<Integer>> entry2 : categoryToItems.entrySet()) {
                if (entry1.getKey() == entry2.getKey()) continue;
                List<Integer> items2 = entry2.getValue();
                for (int i = 0; i < items1.size(); i++) {
                    for (int j = 0; j < items2.size(); j++) {
                        result.add(Arrays.asList(items1.get(i), items2.get(j)));
                    }
                }
            }
        }

        return result;
    }
}
}