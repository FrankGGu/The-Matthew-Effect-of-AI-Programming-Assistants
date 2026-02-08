public class Solution {

import java.util.*;

public class Solution {
    public int longestSubstring(String s, int k) {
        return dfs(s, 0, s.length() - 1, k);
    }

    private int dfs(String s, int left, int right, int k) {
        if (left > right) return 0;
        int[] count = new int[26];
        for (int i = left; i <= right; i++) {
            count[s.charAt(i) - 'a']++;
        }
        char split = 0;
        for (int i = left; i <= right; i++) {
            if (count[s.charAt(i) - 'a'] < k) {
                split = s.charAt(i);
                break;
            }
        }
        if (split == 0) return right - left + 1;
        int res = 0;
        int start = left;
        for (int i = left; i <= right; i++) {
            if (s.charAt(i) == split) {
                res = Math.max(res, dfs(s, start, i - 1, k));
                start = i + 1;
            }
        }
        res = Math.max(res, dfs(s, start, right, k));
        return res;
    }
}
}