import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int minLength(String s) {
        Map<Character, Integer> countMap = new HashMap<>();
        for (char c : s.toCharArray()) {
            countMap.put(c, countMap.getOrDefault(c, 0) + 1);
        }
        int oddCount = 0;
        for (int count : countMap.values()) {
            if (count % 2 != 0) {
                oddCount++;
            }
        }
        return s.length() - oddCount;
    }
}