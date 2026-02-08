public class Solution {

import java.util.*;

public class Solution {
    public String findKeyboardString(String[] keys, int[][] positions) {
        Map<Character, int[]> keyMap = new HashMap<>();
        for (int i = 0; i < keys.length; i++) {
            char key = keys[i].charAt(0);
            keyMap.put(key, positions[i]);
        }

        List<Character> result = new ArrayList<>();
        for (char c = 'a'; c <= 'z'; c++) {
            if (keyMap.containsKey(c)) {
                result.add(c);
            }
        }

        StringBuilder sb = new StringBuilder();
        for (char c : result) {
            sb.append(c);
        }

        return sb.toString();
    }
}
}