import java.util.HashMap;

public class Solution {
    public String mostCommonResponse(String[] responses) {
        HashMap<String, Integer> countMap = new HashMap<>();
        String mostCommon = "";
        int maxCount = 0;

        for (String response : responses) {
            countMap.put(response, countMap.getOrDefault(response, 0) + 1);
            if (countMap.get(response) > maxCount) {
                maxCount = countMap.get(response);
                mostCommon = response;
            }
        }
        return mostCommon;
    }
}