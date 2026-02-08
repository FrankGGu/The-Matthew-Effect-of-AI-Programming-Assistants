public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public boolean areOccurrencesEqual(String s) {
        Map<Character, Integer> countMap = new HashMap<>();
        for (char c : s.toCharArray()) {
            countMap.put(c, countMap.getOrDefault(c, 0) + 1);
        }
        int firstCount = -1;
        for (int count : countMap.values()) {
            if (firstCount == -1) {
                firstCount = count;
            } else if (count != firstCount) {
                return false;
            }
        }
        return true;
    }
}
}