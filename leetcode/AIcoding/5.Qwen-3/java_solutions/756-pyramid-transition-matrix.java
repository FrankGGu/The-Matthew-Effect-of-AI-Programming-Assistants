public class Solution {

import java.util.*;

public class Solution {
    public boolean pyramidTransitionMatrix(String bottom, List<String> allowed) {
        Map<String, List<String>> map = new HashMap<>();
        for (String s : allowed) {
            String key = s.substring(0, 2);
            map.putIfAbsent(key, new ArrayList<>());
            map.get(key).add(s.substring(2));
        }
        return dfs(bottom, map, new StringBuilder(), 0, bottom.length() - 1);
    }

    private boolean dfs(String current, Map<String, List<String>> map, StringBuilder next, int pos, int targetLen) {
        if (current.length() == 1) {
            return true;
        }
        if (pos == current.length() - 1) {
            return dfs(next.toString(), map, new StringBuilder(), 0, targetLen - 1);
        }
        String key = current.substring(pos, pos + 2);
        if (!map.containsKey(key)) {
            return false;
        }
        for (String c : map.get(key)) {
            next.append(c);
            if (dfs(current, map, next, pos + 1, targetLen)) {
                return true;
            }
            next.setLength(next.length() - 1);
        }
        return false;
    }
}
}