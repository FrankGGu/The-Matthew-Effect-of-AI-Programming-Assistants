public class Solution {

import java.util.*;

public class Solution {
    public int inventoryManagement(int[] stock, int cnt) {
        if (stock == null || cnt == 0) return 0;
        Map<Integer, Integer> frequency = new HashMap<>();
        for (int num : stock) {
            frequency.put(num, frequency.getOrDefault(num, 0) + 1);
        }
        List<Map.Entry<Integer, Integer>> list = new ArrayList<>(frequency.entrySet());
        list.sort((a, b) -> a.getValue() - b.getValue());
        int result = 0;
        for (int i = 0; i < cnt; i++) {
            result += list.get(i).getKey();
        }
        return result;
    }
}
}