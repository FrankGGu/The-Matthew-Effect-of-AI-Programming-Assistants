import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

class Solution {
    public List<List<String>> displayTable(List<List<String>> orders) {
        Set<String> foodItemsSet = new TreeSet<>();
        Set<Integer> tableNumbersSet = new TreeSet<>();
        Map<Integer, Map<String, Integer>> tableFoodCounts = new HashMap<>();

        for (List<String> order : orders) {
            int tableNumber = Integer.parseInt(order.get(1));
            String foodItem = order.get(2);

            foodItemsSet.add(foodItem);
            tableNumbersSet.add(tableNumber);

            tableFoodCounts.putIfAbsent(tableNumber, new HashMap<>());
            tableFoodCounts.get(tableNumber).put(foodItem, tableFoodCounts.get(tableNumber).getOrDefault(foodItem, 0) + 1);
        }

        List<String> sortedFoodItems = new ArrayList<>(foodItemsSet);
        List<Integer> sortedTableNumbers = new ArrayList<>(tableNumbersSet);

        List<List<String>> result = new ArrayList<>();

        List<String> header = new ArrayList<>();
        header.add("Table");
        header.addAll(sortedFoodItems);
        result.add(header);

        for (int tableNumber : sortedTableNumbers) {
            List<String> row = new ArrayList<>();
            row.add(String.valueOf(tableNumber));
            Map<String, Integer> currentTableOrders = tableFoodCounts.getOrDefault(tableNumber, new HashMap<>());

            for (String foodItem : sortedFoodItems) {
                row.add(String.valueOf(currentTableOrders.getOrDefault(foodItem, 0)));
            }
            result.add(row);
        }

        return result;
    }
}