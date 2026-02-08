class Solution {
    public int maximumLength(String s) {
        int maxLen = -1;
        for (int i = 0; i < s.length(); i++) {
            for (int j = i + 1; j <= s.length(); j++) {
                String sub = s.substring(i, j);
                if (isSpecial(sub) && countOccurrences(s, sub) >= 3) {
                    maxLen = Math.max(maxLen, sub.length());
                }
            }
        }
        return maxLen;
    }

    private boolean isSpecial(String s) {
        char c = s.charAt(0);
        for (int i = 1; i < s.length(); i++) {
            if (s.charAt(i) != c) {
                return false;
            }
        }
        return true;
    }

    private int countOccurrences(String s, String sub) {
        int count = 0;
        int index = s.indexOf(sub);
        while (index != -1) {
            count++;
            index = s.indexOf(sub, index + 1);
        }
        return count;
    }
}