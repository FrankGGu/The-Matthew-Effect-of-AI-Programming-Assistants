class Solution {
    public String findLongestSpecialSubstring(String s) {
        int n = s.length();
        String result = "";

        for (int len = n / 3; len > 0; len--) {
            for (int i = 0; i <= n - len; i++) {
                String sub = s.substring(i, i + len);
                if (countOccurrences(s, sub) == 3) {
                    return sub;
                }
            }
        }
        return result;
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