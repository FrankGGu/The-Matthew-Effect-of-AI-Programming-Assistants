public class Solution {

import java.util.*;

public class Solution {
    public boolean splitString(String s) {
        for (int i = 1; i < s.length(); i++) {
            long first = Long.parseLong(s.substring(0, i));
            if (dfs(s, i, first)) {
                return true;
            }
        }
        return false;
    }

    private boolean dfs(String s, int index, long prev) {
        if (index == s.length()) {
            return true;
        }
        for (int i = index + 1; i <= s.length(); i++) {
            long current = Long.parseLong(s.substring(index, i));
            if (current == prev) {
                if (dfs(s, i, current)) {
                    return true;
                }
            } else if (current > prev) {
                break;
            }
        }
        return false;
    }
}
}