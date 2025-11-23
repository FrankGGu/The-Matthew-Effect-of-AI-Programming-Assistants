import java.util.HashMap;
import java.util.Map;

class Solution {
    public String mostCommonResponse(String[] responses) {
        Map<String, Integer> counts = new HashMap<>();
        for (String response : responses) {
            counts.put(response, counts.getOrDefault(response, 0) + 1);
        }

        String mostCommon = null;
        int maxCount = 0;

        for (Map.Entry<String, Integer> entry : counts.entrySet()) {
            if (entry.getValue() > maxCount) {
                maxCount = entry.getValue();
                mostCommon = entry.getKey();
            }
        }

        return mostCommon;
    }
}