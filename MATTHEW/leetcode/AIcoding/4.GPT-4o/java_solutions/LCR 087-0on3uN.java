import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<String> restoreIpAddresses(String s) {
        List<String> result = new ArrayList<>();
        backtrack(s, 0, 0, "", result);
        return result;
    }

    private void backtrack(String s, int start, int partCount, String current, List<String> result) {
        if (partCount == 4 && start == s.length()) {
            result.add(current.substring(0, current.length() - 1));
            return;
        }
        if (partCount >= 4) return;

        for (int len = 1; len <= 3; len++) {
            if (start + len > s.length()) break;
            String segment = s.substring(start, start + len);
            int value = Integer.parseInt(segment);
            if (String.valueOf(value).length() != segment.length() || value > 255) continue;
            backtrack(s, start + len, partCount + 1, current + segment + ".", result);
        }
    }
}