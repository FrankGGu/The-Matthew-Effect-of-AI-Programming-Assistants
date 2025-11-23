import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public List<List<Integer>> findMatrix(int[] nums) {
        Map<Integer, Integer> counts = new HashMap<>();
        for (int num : nums) {
            counts.put(num, counts.getOrDefault(num, 0) + 1);
        }

        List<List<Integer>> result = new ArrayList<>();
        while (!counts.isEmpty()) {
            List<Integer> row = new ArrayList<>();
            List<Integer> toRemove = new ArrayList<>();
            for (Map.Entry<Integer, Integer> entry : counts.entrySet()) {
                row.add(entry.getKey());
                counts.put(entry.getKey(), entry.getValue() - 1);
                if (counts.get(entry.getKey()) == 0) {
                    toRemove.add(entry.getKey());
                }
            }
            for (Integer key : toRemove) {
                counts.remove(key);
            }
            result.add(row);
        }

        return result;
    }
}