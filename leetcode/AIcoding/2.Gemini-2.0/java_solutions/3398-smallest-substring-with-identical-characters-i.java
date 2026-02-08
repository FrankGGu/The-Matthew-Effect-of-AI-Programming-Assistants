class Solution {
    public int smallestSubstring(String s) {
        int n = s.length();
        int minLen = -1;
        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                String sub = s.substring(i, j + 1);
                if (isIdentical(sub)) {
                    if (minLen == -1 || sub.length() < minLen) {
                        minLen = sub.length();
                    }
                }
            }
        }
        return minLen;
    }

    private boolean isIdentical(String s) {
        if (s.length() == 0) {
            return false;
        }
        char first = s.charAt(0);
        for (int i = 1; i < s.length(); i++) {
            if (s.charAt(i) != first) {
                return false;
            }
        }
        return true;
    }
}