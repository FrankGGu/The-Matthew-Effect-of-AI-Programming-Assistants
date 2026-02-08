class Solution {
    public boolean splitString(String s) {
        for (int i = 1; i < s.length(); i++) {
            long first = Long.parseLong(s.substring(0, i));
            if (isValid(s, i, first)) {
                return true;
            }
        }
        return false;
    }

    private boolean isValid(String s, int index, long prev) {
        if (index == s.length()) {
            return true;
        }

        for (int i = index + 1; i <= s.length(); i++) {
            long current = Long.parseLong(s.substring(index, i));
            if (current == prev - 1) {
                if (isValid(s, i, current)) {
                    return true;
                }
            }
        }
        return false;
    }
}