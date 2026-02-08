public class Solution {

import java.util.*;

public class InventoryManagement {
    public int inventoryManagement(int[] stock, int cnt) {
        Map<Integer, Integer> frequencyMap = new HashMap<>();
        for (int num : stock) {
            frequencyMap.put(num, frequencyMap.getOrDefault(num, 0) + 1);
        }

        List<Map.Entry<Integer, Integer>> entries = new ArrayList<>(frequencyMap.entrySet());
        entries.sort((a, b) -> a.getValue() - b.getValue());

        int result = 0;
        for (int i = 0; i < cnt; i++) {
            result += entries.get(i).getKey();
        }

        return result;
    }
}
}