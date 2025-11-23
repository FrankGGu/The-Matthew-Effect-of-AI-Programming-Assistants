public class Solution {

import java.util.*;

public class Solution {
    public int numTilePossibilities(String s) {
        Map<Character, Integer> count = new HashMap<>();
        for (char c : s.toCharArray()) {
            count.put(c, count.getOrDefault(c, 0) + 1);
        }
        return dfs(count);
    }

    private int dfs(Map<Character, Integer> count) {
        int result = 0;
        for (char c : count.keySet()) {
            if (count.get(c) > 0) {
                count.put(c, count.get(c) - 1);
                result += 1 + dfs(count);
                count.put(c, count.get(c) + 1);
            }
        }
        return result;
    }
}
}