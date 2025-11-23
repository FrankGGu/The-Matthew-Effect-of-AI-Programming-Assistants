import java.util.List;

class Solution {
    public List<List<Integer>> displayTable(List<List<String>> orders) {
        java.util.TreeSet<String> items = new java.util.TreeSet<>();
        java.util.TreeMap<Integer, java.util.HashMap<String, Integer>> tableOrders = new java.util.TreeMap<>();

        for (List<String> order : orders) {
            int table = Integer.parseInt(order.get(1));
            String item = order.get(2);

            items.add(item);

            tableOrders.putIfAbsent(table, new java.util.HashMap<>());
            tableOrders.get(table).put(item, tableOrders.get(table).getOrDefault(item, 0) + 1);
        }

        List<List<Integer>> result = new java.util.ArrayList<>();
        List<String> header = new java.util.ArrayList<>();
        header.add("Table");
        header.addAll(items);

        List<Integer> headerInt = new java.util.ArrayList<>();
        headerInt.add(-1);

        for(String item : items){
            headerInt.add(-1);
        }

        result.add((List)header);

        for (Integer table : tableOrders.keySet()) {
            List<Integer> row = new java.util.ArrayList<>();
            row.add(table);

            for (String item : items) {
                row.add(tableOrders.get(table).getOrDefault(item, 0));
            }

            result.add((List)row);
        }
        if (result.size() > 3) {
            return result.subList(0, Math.min(3, result.size()));
        }

        return result;
    }
}