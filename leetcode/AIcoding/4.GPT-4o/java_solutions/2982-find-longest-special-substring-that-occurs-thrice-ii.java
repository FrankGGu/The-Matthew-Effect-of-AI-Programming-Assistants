class Solution {
    public String longestSpecialSubstring(String s) {
        int n = s.length();
        String longest = "";
        for (int len = n; len >= 1; len--) {
            for (int i = 0; i <= n - len; i++) {
                String sub = s.substring(i, i + len);
                if (countOccurrences(s, sub) == 3) {
                    if (sub.length() > longest.length()) {
                        longest = sub;
                    }
                }
            }
            if (!longest.isEmpty()) break;
        }
        return longest;
    }

    private int countOccurrences(String s, String sub) {
        int count = 0;
        int index = 0;
        while ((index = s.indexOf(sub, index)) != -1) {
            count++;
            index += sub.length();
        }
        return count;
    }
}