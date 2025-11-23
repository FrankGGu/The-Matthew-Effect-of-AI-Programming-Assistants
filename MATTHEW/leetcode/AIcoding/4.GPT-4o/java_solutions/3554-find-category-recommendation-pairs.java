import java.util.*;

public class Solution {
    public List<List<String>> recommendedPairs(String[] items, String[][] categories) {
        Map<String, Set<String>> categoryMap = new HashMap<>();
        for (String[] category : categories) {
            for (int i = 1; i < category.length; i++) {
                categoryMap.putIfAbsent(category[i], new HashSet<>());
                categoryMap.get(category[i]).add(category[0]);
            }
        }

        Set<String> itemSet = new HashSet<>(Arrays.asList(items));
        List<List<String>> result = new ArrayList<>();

        for (String item : items) {
            if (!categoryMap.containsKey(item)) continue;
            Set<String> categoriesForItem = categoryMap.get(item);
            for (String category : categoriesForItem) {
                for (String otherItem : categoryMap.get(category)) {
                    if (!otherItem.equals(item) && itemSet.contains(otherItem)) {
                        result.add(Arrays.asList(item, otherItem));
                    }
                }
            }
        }

        return result;
    }
}