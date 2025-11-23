import java.util.*;

class Solution {
    public String mostCommonResponse(String[] responses) {
        Map<String, Integer> frequencyMap = new HashMap<>();
        for (String response : responses) {
            frequencyMap.put(response, frequencyMap.getOrDefault(response, 0) + 1);
        }

        String mostCommon = "";
        int maxFrequency = 0;
        for (Map.Entry<String, Integer> entry : frequencyMap.entrySet()) {
            if (entry.getValue() > maxFrequency) {
                maxFrequency = entry.getValue();
                mostCommon = entry.getKey();
            }
        }

        return mostCommon;
    }
}