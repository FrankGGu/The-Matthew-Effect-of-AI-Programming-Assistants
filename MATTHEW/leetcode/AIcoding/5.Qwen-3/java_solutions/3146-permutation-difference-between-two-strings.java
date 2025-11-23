public class Solution {

import java.util.*;

public class Solution {
    public int permutationDifference(String s, String t) {
        Map<Character, Integer> indexMap = new HashMap<>();
        for (int i = 0; i < s.length(); i++) {
            indexMap.put(s.charAt(i), i);
        }
        int result = 0;
        for (int i = 0; i < t.length(); i++) {
            result += Math.abs(indexMap.get(t.charAt(i)) - i);
        }
        return result;
    }
}
}