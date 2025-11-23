public class Solution {

import java.util.*;

public class Solution {
    public String findSpecialSubstring(String s, int k) {
        Map<String, Integer> map = new HashMap<>();
        int n = s.length();
        for (int i = 0; i <= n - k; i++) {
            String sub = s.substring(i, i + k);
            map.put(sub, map.getOrDefault(sub, 0) + 1);
        }
        for (Map.Entry<String, Integer> entry : map.entrySet()) {
            if (entry.getValue() > 1) {
                return entry.getKey();
            }
        }
        return "";
    }
}
}