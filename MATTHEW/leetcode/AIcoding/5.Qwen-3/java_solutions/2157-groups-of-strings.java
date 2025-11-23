public class Solution {

import java.util.*;

public class Solution {
    public List<List<String>> groupTheStrings(int[] nums) {
        Map<String, List<String>> map = new HashMap<>();
        for (int num : nums) {
            String key = "";
            int prev = num % 10;
            for (int i = num / 10; i > 0; i /= 10) {
                int curr = i % 10;
                key = (curr - prev + 10) % 10 + key;
                prev = curr;
            }
            map.computeIfAbsent(key, k -> new ArrayList<>()).add(String.valueOf(num));
        }
        return new ArrayList<>(map.values());
    }
}
}