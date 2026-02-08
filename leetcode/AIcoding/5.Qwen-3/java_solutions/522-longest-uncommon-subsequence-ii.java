public class Solution {

import java.util.*;

public class Solution {
    public int findLongestSubsequenceLength(String[] strs) {
        Arrays.sort(strs, (a, b) -> b.length() - a.length());
        Set<String> set = new HashSet<>();
        for (int i = 0; i < strs.length; i++) {
            if (set.contains(strs[i])) {
                continue;
            }
            boolean isUnique = true;
            for (int j = 0; j < strs.length; j++) {
                if (i != j && isSubsequence(strs[i], strs[j])) {
                    isUnique = false;
                    break;
                }
            }
            if (isUnique) {
                return strs[i].length();
            }
            set.add(strs[i]);
        }
        return -1;
    }

    private boolean isSubsequence(String s, String t) {
        int i = 0, j = 0;
        while (i < s.length() && j < t.length()) {
            if (s.charAt(i) == t.charAt(j)) {
                i++;
            }
            j++;
        }
        return i == s.length();
    }
}
}