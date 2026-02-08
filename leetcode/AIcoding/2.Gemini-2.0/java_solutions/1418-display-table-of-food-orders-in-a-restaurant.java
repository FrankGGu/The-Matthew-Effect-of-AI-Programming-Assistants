import java.util.*;

class Solution {
    public List<List<String>> displayTable(List<List<String>> orders) {
        Set<String> foods = new TreeSet<>();
        Map<Integer, Map<String, Integer>> tableOrders = new TreeMap<>();

        for (List<String> order : orders) {
            int table = Integer.parseInt(order.get(1));
            String food = order.get(2);

            foods.add(food);

            tableOrders.putIfAbsent(table, new HashMap<>());
            tableOrders.get(table).put(food, tableOrders.get(table).getOrDefault(food, 0) + 1);
        }

        List<List<String>> result = new ArrayList<>();
        List<String> header = new ArrayList<>();
        header.add("Table");
        header.addAll(foods);
        result.add(header);

        for (int table : tableOrders.keySet()) {
            List<String> row = new ArrayList<>();
            row.add(String.valueOf(table));

            for (String food : foods) {
                row.add(String.valueOf(tableOrders.get(table).getOrDefault(food, 0)));
            }

            result.add(row);
        }

        return result;
    }
}