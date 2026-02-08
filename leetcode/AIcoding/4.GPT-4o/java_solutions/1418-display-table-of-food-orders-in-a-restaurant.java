import java.util.*;

class Solution {
    public List<List<String>> displayTable(List<List<String>> orders) {
        Set<String> foodSet = new TreeSet<>();
        Map<String, Map<String, Integer>> tableMap = new TreeMap<>();

        for (List<String> order : orders) {
            String table = order.get(1);
            String food = order.get(2);
            foodSet.add(food);
            tableMap.putIfAbsent(table, new TreeMap<>());
            tableMap.get(table).put(food, tableMap.get(table).getOrDefault(food, 0) + 1);
        }

        List<List<String>> result = new ArrayList<>();
        List<String> header = new ArrayList<>();
        header.add("Table");
        header.addAll(foodSet);
        result.add(header);

        for (String table : tableMap.keySet()) {
            List<String> row = new ArrayList<>();
            row.add(table);
            for (String food : foodSet) {
                row.add(String.valueOf(tableMap.get(table).getOrDefault(food, 0)));
            }
            result.add(row);
        }

        return result;
    }
}