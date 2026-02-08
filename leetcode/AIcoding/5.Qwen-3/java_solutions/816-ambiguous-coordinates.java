public class Solution {

import java.util.*;

public class Solution {
    public List<String> ambiguousCoordinates(String s) {
        List<String> result = new ArrayList<>();
        for (int i = 1; i < s.length() - 1; i++) {
            List<String> left = generate(s.substring(0, i));
            List<String> right = generate(s.substring(i));
            for (String l : left) {
                for (String r : right) {
                    result.add("(" + l + ", " + r + ")");
                }
            }
        }
        return result;
    }

    private List<String> generate(String s) {
        List<String> result = new ArrayList<>();
        if (s.length() == 1) {
            result.add(s);
            return result;
        }
        if (s.charAt(0) != '0') {
            result.add(s);
        }
        for (int i = 1; i < s.length(); i++) {
            if (s.charAt(0) == '0' && i < s.length() - 1) {
                continue;
            }
            result.add(s.substring(0, i) + "." + s.substring(i));
        }
        return result;
    }
}
}