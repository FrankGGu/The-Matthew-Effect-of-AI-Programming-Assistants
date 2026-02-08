import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<String> restoreIpAddresses(String s) {
        List<String> result = new ArrayList<>();
        backtrack(result, s, new StringBuilder(), 0, 0);
        return result;
    }

    private void backtrack(List<String> result, String s, StringBuilder current, int index, int part) {
        if (part == 4 && index == s.length()) {
            result.add(current.toString());
            return;
        }
        if (part >= 4) return;

        for (int len = 1; len <= 3; len++) {
            if (index + len > s.length()) break;
            String segment = s.substring(index, index + len);
            if (isValid(segment)) {
                int currentLength = current.length();
                if (currentLength != 0) current.append(".");
                current.append(segment);
                backtrack(result, s, current, index + len, part + 1);
                current.setLength(currentLength);
            }
        }
    }

    private boolean isValid(String segment) {
        if (segment.length() > 1 && segment.charAt(0) == '0') return false;
        int num = Integer.parseInt(segment);
        return num >= 0 && num <= 255;
    }
}