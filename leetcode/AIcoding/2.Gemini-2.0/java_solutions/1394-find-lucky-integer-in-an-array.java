import java.util.HashMap;
import java.util.Map;

class Solution {
    public int findLucky(int[] arr) {
        Map<Integer, Integer> counts = new HashMap<>();
        for (int num : arr) {
            counts.put(num, counts.getOrDefault(num, 0) + 1);
        }

        int lucky = -1;
        for (Map.Entry<Integer, Integer> entry : counts.entrySet()) {
            if (entry.getKey() == entry.getValue()) {
                lucky = Math.max(lucky, entry.getKey());
            }
        }

        return lucky;
    }
}