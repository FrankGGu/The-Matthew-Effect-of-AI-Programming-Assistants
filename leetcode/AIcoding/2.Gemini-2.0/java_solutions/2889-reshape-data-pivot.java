import java.util.*;

class Solution {
    public List<List<Object>> pivotArray(String[] categories, String targetKey, String targetValue, List<List<Object>> data) {
        Map<String, Map<String, Object>> pivotedData = new HashMap<>();
        Set<String> valueSet = new HashSet<>();

        for (List<Object> row : data) {
            String category = (String) row.get(0);
            String key = (String) row.get(Arrays.asList(categories).indexOf(targetKey));
            Object value = row.get(Arrays.asList(categories).indexOf(targetValue));

            if (!pivotedData.containsKey(category)) {
                pivotedData.put(category, new HashMap<>());
            }
            pivotedData.get(category).put(key, value);
            valueSet.add(key);
        }

        List<String> sortedValues = new ArrayList<>(valueSet);
        Collections.sort(sortedValues);

        List<List<Object>> result = new ArrayList<>();
        List<Object> header = new ArrayList<>();
        header.add("category");
        header.addAll(sortedValues);
        result.add(header);

        List<String> sortedCategories = new ArrayList<>(pivotedData.keySet());
        Collections.sort(sortedCategories);

        for (String category : sortedCategories) {
            List<Object> row = new ArrayList<>();
            row.add(category);
            for (String value : sortedValues) {
                row.add(pivotedData.get(category).getOrDefault(value, null));
            }
            result.add(row);
        }

        return result;
    }
}