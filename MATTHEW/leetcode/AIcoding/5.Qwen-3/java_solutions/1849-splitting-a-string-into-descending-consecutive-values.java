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

    private boolean dfs(String s, int start, long prev) {
        if (start == s.length()) {
            return true;
        }
        for (int i = start + 1; i <= s.length(); i++) {
            long current = Long.parseLong(s.substring(start, i));
            if (current + 1 == prev && dfs(s, i, current)) {
                return true;
            }
        }
        return false;
    }
}