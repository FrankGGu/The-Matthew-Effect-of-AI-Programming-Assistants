public class Solution {

import java.util.*;

public class Solution {
    public List<List<String>> displayTable(List<List<String>> orders) {
        Set<String> foodSet = new HashSet<>();
        Map<String, Map<String, Integer>> tableMap = new HashMap<>();

        for (List<String> order : orders) {
            String tableNumber = order.get(0);
            String food = order.get(1);
            foodSet.add(food);

            tableMap.putIfAbsent(tableNumber, new HashMap<>());
            Map<String, Integer> foodCount = tableMap.get(tableNumber);
            foodCount.put(food, foodCount.getOrDefault(food, 0) + 1);
        }

        List<String> foods = new ArrayList<>(foodSet);
        Collections.sort(foods);

        List<String> tables = new ArrayList<>(tableMap.keySet());
        Collections.sort(tables, (a, b) -> Integer.compare(Integer.parseInt(a), Integer.parseInt(b)));

        List<List<String>> result = new ArrayList<>();
        List<String> header = new ArrayList<>();
        header.add("Table");
        header.addAll(foods);
        result.add(header);

        for (String table : tables) {
            List<String> row = new ArrayList<>();
            row.add(table);
            for (String food : foods) {
                row.add(String.valueOf(tableMap.get(table).getOrDefault(food, 0)));
            }
            result.add(row);
        }

        return result;
    }
}
}