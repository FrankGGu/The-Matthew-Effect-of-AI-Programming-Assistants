class Solution {
    public boolean splitString(String s) {
        return backtrack(s, 0, -1, 0);
    }

    private boolean backtrack(String s, int index, long prev, int count) {
        if (index == s.length()) {
            return count >= 2;
        }
        long current = 0;
        for (int i = index; i < s.length(); i++) {
            current = current * 10 + (s.charAt(i) - '0');
            if (prev == -1 || current == prev - 1) {
                if (backtrack(s, i + 1, current, count + 1)) {
                    return true;
                }
            }
            if (current >= prev && prev != -1) {
                break;
            }
        }
        return false;
    }
}