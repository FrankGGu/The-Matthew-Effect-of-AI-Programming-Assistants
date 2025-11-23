import java.util.HashSet;
import java.util.Set;

class Solution {
    private int maxCount;
    private String s;

    public int maxUniqueSplit(String s) {
        this.s = s;
        this.maxCount = 0;
        backtrack(0, new HashSet<>());
        return maxCount;
    }

    private void backtrack(int index, Set<String> currentSubstrings) {
        if (index == s.length()) {
            maxCount = Math.max(maxCount, currentSubstrings.size());
            return;
        }

        for (int i = index; i < s.length(); i++) {
            String sub = s.substring(index, i + 1);
            if (!currentSubstrings.contains(sub)) {
                currentSubstrings.add(sub);
                backtrack(i + 1, currentSubstrings);
                currentSubstrings.remove(sub);
            }
        }
    }
}