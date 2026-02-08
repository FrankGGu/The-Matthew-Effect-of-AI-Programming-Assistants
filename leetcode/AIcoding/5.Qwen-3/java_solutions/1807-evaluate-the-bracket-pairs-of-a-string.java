public class Solution {

import java.util.*;

public class Solution {
    public String evaluate(String s, List<List<String>> knowledge) {
        Map<String, String> map = new HashMap<>();
        for (List<String> pair : knowledge) {
            map.put(pair.get(0), pair.get(1));
        }
        StringBuilder result = new StringBuilder();
        StringBuilder key = new StringBuilder();
        boolean inKey = false;
        for (char c : s.toCharArray()) {
            if (c == '(') {
                inKey = true;
                key = new StringBuilder();
            } else if (c == ')') {
                inKey = false;
                result.append(map.getOrDefault(key.toString(), ""));
            } else if (inKey) {
                key.append(c);
            } else {
                result.append(c);
            }
        }
        return result.toString();
    }
}
}