import java.util.HashSet;
import java.util.Set;

public class Solution {
    public int maxUniqueSplit(String s) {
        Set<String> seen = new HashSet<>();
        return backtrack(s, 0, seen);
    }

    private int backtrack(String s, int start, Set<String> seen) {
        if (start == s.length()) {
            return seen.size();
        }
        int maxCount = 0;
        for (int end = start + 1; end <= s.length(); end++) {
            String substr = s.substring(start, end);
            if (!seen.contains(substr)) {
                seen.add(substr);
                maxCount = Math.max(maxCount, backtrack(s, end, seen));
                seen.remove(substr);
            }
        }
        return maxCount;
    }
}