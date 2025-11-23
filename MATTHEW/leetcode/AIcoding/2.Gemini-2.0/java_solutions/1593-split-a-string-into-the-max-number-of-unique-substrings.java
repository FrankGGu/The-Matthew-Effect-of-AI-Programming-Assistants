import java.util.HashSet;
import java.util.Set;

class Solution {
    int maxUnique = 0;

    public int maxUniqueSplit(String s) {
        maxUnique = 0;
        backtrack(s, 0, new HashSet<>());
        return maxUnique;
    }

    private void backtrack(String s, int start, Set<String> used) {
        if (start == s.length()) {
            maxUnique = Math.max(maxUnique, used.size());
            return;
        }

        for (int i = start; i < s.length(); i++) {
            String sub = s.substring(start, i + 1);
            if (!used.contains(sub)) {
                used.add(sub);
                backtrack(s, i + 1, used);
                used.remove(sub);
            }
        }
    }
}