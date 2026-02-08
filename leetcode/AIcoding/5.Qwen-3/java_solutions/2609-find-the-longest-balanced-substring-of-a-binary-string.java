public class Solution {
    public String longestBalancedSubstring(String s) {
        int maxLen = 0;
        int start = 0;
        int count0 = 0, count1 = 0;

        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == '0') {
                count0++;
            } else {
                count1++;
            }

            if (count0 == count1) {
                if (i - start + 1 > maxLen) {
                    maxLen = i - start + 1;
                }
            } else if (count0 < count1) {
                count0 = 0;
                count1 = 0;
                start = i + 1;
            }
        }

        return s.substring(0, maxLen);
    }
}