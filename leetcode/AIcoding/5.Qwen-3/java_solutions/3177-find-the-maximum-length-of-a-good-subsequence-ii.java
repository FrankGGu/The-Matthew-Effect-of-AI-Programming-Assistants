public class Solution {

import java.util.*;

public class Solution {
    public int maxLengthBetweenEqualCharacters(String s) {
        int maxLen = -1;
        Map<Character, List<Integer>> map = new HashMap<>();

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            map.putIfAbsent(c, new ArrayList<>());
            map.get(c).add(i);
        }

        for (List<Integer> indices : map.values()) {
            if (indices.size() >= 2) {
                int len = indices.get(indices.size() - 1) - indices.get(0) - 1;
                maxLen = Math.max(maxLen, len);
            }
        }

        return maxLen;
    }
}
}