import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int minNumberOfValidStrings(String[] validStrings, String target) {
        Map<Character, Integer> targetCount = new HashMap<>();
        for (char c : target.toCharArray()) {
            targetCount.put(c, targetCount.getOrDefault(c, 0) + 1);
        }

        int result = Integer.MAX_VALUE;
        for (String valid : validStrings) {
            Map<Character, Integer> validCount = new HashMap<>();
            for (char c : valid.toCharArray()) {
                validCount.put(c, validCount.getOrDefault(c, 0) + 1);
            }
            if (canFormTarget(validCount, targetCount)) {
                result = Math.min(result, valid.length());
            }
        }

        return result == Integer.MAX_VALUE ? -1 : result;
    }

    private boolean canFormTarget(Map<Character, Integer> validCount, Map<Character, Integer> targetCount) {
        for (char c : targetCount.keySet()) {
            if (validCount.getOrDefault(c, 0) < targetCount.get(c)) {
                return false;
            }
        }
        return true;
    }
}