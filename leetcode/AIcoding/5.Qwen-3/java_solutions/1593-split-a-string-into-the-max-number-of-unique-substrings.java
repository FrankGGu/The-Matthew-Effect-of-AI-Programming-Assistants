public class Solution {

import java.util.HashSet;
import java.util.Set;

public class Solution {
    public int maxUniqueSplit(String s) {
        return backtrack(s, 0, new HashSet<>());
    }

    private int backtrack(String s, int start, Set<String> set) {
        if (start == s.length()) {
            return set.size();
        }
        int max = 0;
        for (int end = start + 1; end <= s.length(); end++) {
            String substr = s.substring(start, end);
            if (!set.contains(substr)) {
                set.add(substr);
                max = Math.max(max, backtrack(s, end, set));
                set.remove(substr);
            }
        }
        return max;
    }
}
}