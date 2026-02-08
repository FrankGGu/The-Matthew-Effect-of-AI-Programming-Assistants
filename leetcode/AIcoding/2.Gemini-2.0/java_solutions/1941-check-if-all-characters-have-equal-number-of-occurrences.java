import java.util.HashMap;
import java.util.Map;

class Solution {
    public boolean areOccurrencesEqual(String s) {
        Map<Character, Integer> counts = new HashMap<>();
        for (char c : s.toCharArray()) {
            counts.put(c, counts.getOrDefault(c, 0) + 1);
        }

        int firstCount = -1;
        for (int count : counts.values()) {
            if (firstCount == -1) {
                firstCount = count;
            } else if (count != firstCount) {
                return false;
            }
        }

        return true;
    }
}