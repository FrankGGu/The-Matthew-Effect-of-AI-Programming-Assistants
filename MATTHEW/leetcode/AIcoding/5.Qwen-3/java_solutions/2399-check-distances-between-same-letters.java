public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public boolean checkDistances(String s) {
        Map<Character, Integer> lastIndex = new HashMap<>();
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (lastIndex.containsKey(c)) {
                int distance = i - lastIndex.get(c) - 1;
                if (distance != s.charAt(i) - 'a') {
                    return false;
                }
            } else {
                lastIndex.put(c, i);
            }
        }
        return true;
    }
}
}