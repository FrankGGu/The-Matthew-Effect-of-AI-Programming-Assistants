import java.util.*;

class Solution {
    public int findLUSlength(String[] strs) {
        Arrays.sort(strs, (a, b) -> b.length() - a.length());
        for (int i = 0; i < strs.length; i++) {
            boolean isSubsequence = false;
            for (int j = 0; j < strs.length; j++) {
                if (i == j) continue;
                if (isSubsequence(strs[j], strs[i])) {
                    isSubsequence = true;
                    break;
                }
            }
            if (!isSubsequence) {
                return strs[i].length();
            }
        }
        return -1;
    }

    private boolean isSubsequence(String s, String t) {
        int i = 0, j = 0;
        while (i < s.length() && j < t.length()) {
            if (s.charAt(i) == t.charAt(j)) {
                j++;
            }
            i++;
        }
        return j == t.length();
    }
}