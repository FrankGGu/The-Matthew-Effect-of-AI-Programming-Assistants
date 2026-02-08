import java.util.*;

class Solution {
    public List<String> highAccessEmployees(String[][] logs, int threshold) {
        Map<String, Integer> accessCount = new HashMap<>();

        for (String[] log : logs) {
            accessCount.put(log[0], accessCount.getOrDefault(log[0], 0) + 1);
        }

        List<String> result = new ArrayList<>();
        for (Map.Entry<String, Integer> entry : accessCount.entrySet()) {
            if (entry.getValue() >= threshold) {
                result.add(entry.getKey());
            }
        }

        Collections.sort(result);
        return result;
    }
}