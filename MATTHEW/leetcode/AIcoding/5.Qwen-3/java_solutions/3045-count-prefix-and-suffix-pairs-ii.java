public class Solution {

import java.util.*;

public class Solution {
    public int countPrefixSuffixPairs(int[] nums) {
        Map<String, Integer> map = new HashMap<>();
        int count = 0;
        for (int num : nums) {
            String s = String.valueOf(num);
            for (Map.Entry<String, Integer> entry : map.entrySet()) {
                if (s.startsWith(entry.getKey()) && s.endsWith(entry.getKey())) {
                    count += entry.getValue();
                }
            }
            map.put(s, map.getOrDefault(s, 0) + 1);
        }
        return count;
    }
}
}