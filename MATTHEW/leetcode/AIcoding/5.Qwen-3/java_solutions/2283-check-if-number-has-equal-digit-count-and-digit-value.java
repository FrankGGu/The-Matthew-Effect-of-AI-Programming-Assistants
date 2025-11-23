public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public boolean digitCount(String num) {
        Map<Character, Integer> countMap = new HashMap<>();
        for (char c : num.toCharArray()) {
            countMap.put(c, countMap.getOrDefault(c, 0) + 1);
        }
        for (int i = 0; i < num.length(); i++) {
            char digitChar = num.charAt(i);
            int digit = digitChar - '0';
            if (countMap.getOrDefault((char) ('0' + digit), 0) != digit) {
                return false;
            }
        }
        return true;
    }
}
}