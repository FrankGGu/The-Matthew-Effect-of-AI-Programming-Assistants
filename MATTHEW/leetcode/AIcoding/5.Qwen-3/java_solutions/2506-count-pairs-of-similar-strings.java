public class Solution {

import java.util.*;

public class Solution {
    public int similarPairs(String[] words) {
        Map<String, Integer> map = new HashMap<>();
        int count = 0;

        for (String word : words) {
            char[] chars = word.toCharArray();
            Arrays.sort(chars);
            String key = new String(chars);
            map.put(key, map.getOrDefault(key, 0) + 1);
        }

        for (int val : map.values()) {
            if (val >= 2) {
                count += val * (val - 1) / 2;
            }
        }

        return count;
    }
}
}