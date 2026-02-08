import java.util.*;

class Solution {

    public List<Integer> mostFrequentIDs(List<Integer> ids) {
        Map<Integer, Integer> counts = new HashMap<>();
        for (int id : ids) {
            counts.put(id, counts.getOrDefault(id, 0) + 1);
        }

        int maxCount = 0;
        for (int count : counts.values()) {
            maxCount = Math.max(maxCount, count);
        }

        List<Integer> mostFrequent = new ArrayList<>();
        for (Map.Entry<Integer, Integer> entry : counts.entrySet()) {
            if (entry.getValue() == maxCount) {
                mostFrequent.add(entry.getKey());
            }
        }

        return mostFrequent;
    }
}