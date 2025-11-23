public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public boolean isScramble(String s1, String s2) {
        if (s1.length() != s2.length()) return false;
        if (s1.equals(s2)) return true;
        int n = s1.length();
        Map<String, Boolean> memo = new HashMap<>();
        return dfs(s1, s2, memo);
    }

    private boolean dfs(String s1, String s2, Map<String, Boolean> memo) {
        if (s1.length() != s2.length()) return false;
        if (s1.equals(s2)) return true;
        String key = s1 + "," + s2;
        if (memo.containsKey(key)) return memo.get(key);

        for (int i = 1; i < s1.length(); i++) {
            if (dfs(s1.substring(0, i), s2.substring(0, i), memo) && dfs(s1.substring(i), s2.substring(i), memo)) {
                memo.put(key, true);
                return true;
            }
            if (dfs(s1.substring(0, i), s2.substring(s2.length() - i), memo) && dfs(s1.substring(i), s2.substring(0, s2.length() - i), memo)) {
                memo.put(key, true);
                return true;
            }
        }

        memo.put(key, false);
        return false;
    }
}
}