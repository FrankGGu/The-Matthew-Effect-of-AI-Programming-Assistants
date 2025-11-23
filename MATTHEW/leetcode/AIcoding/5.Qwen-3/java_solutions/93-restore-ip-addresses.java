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
                result.add(current);
            }
            return;
        }

        for (int i = 1; i <= 3 && start + i <= s.length(); i++) {
            String segment = s.substring(start, start + i);
            if ((segment.length() > 1 && segment.charAt(0) == '0') || Integer.parseInt(segment) > 255) {
                continue;
            }
            if (current.isEmpty()) {
                backtrack(s, start + i, part + 1, segment, result);
            } else {
                backtrack(s, start + i, part + 1, current + "." + segment, result);
            }
        }
    }
}
}