public class Solution {

import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<String> restoreIpAddresses(String s) {
        List<String> result = new ArrayList<>();
        backtrack(s, 0, 0, "", result);
        return result;
    }

    private void backtrack(String s, int start, int part, String current, List<String> result) {
        if (part == 4) {
            if (start == s.length()) {
                result.add(current.substring(0, current.length() - 1));
            }
            return;
        }

        for (int i = start; i < s.length(); i++) {
            String segment = s.substring(start, i + 1);
            if (segment.length() > 1 && segment.charAt(0) == '0') continue;
            if (Integer.parseInt(segment) > 255) continue;
            backtrack(s, i + 1, part + 1, current + segment + ".", result);
        }
    }
}
}