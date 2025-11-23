import java.util.*;

public class Solution {
    public List<Integer> mostFrequentIDs(int[] ids) {
        Map<Integer, Integer> frequencyMap = new HashMap<>();
        for (int id : ids) {
            frequencyMap.put(id, frequencyMap.getOrDefault(id, 0) + 1);
        }

        int maxFrequency = Collections.max(frequencyMap.values());
        List<Integer> result = new ArrayList<>();

        for (Map.Entry<Integer, Integer> entry : frequencyMap.entrySet()) {
            if (entry.getValue() == maxFrequency) {
                result.add(entry.getKey());
            }
        }

        Collections.sort(result);
        return result;
    }
}