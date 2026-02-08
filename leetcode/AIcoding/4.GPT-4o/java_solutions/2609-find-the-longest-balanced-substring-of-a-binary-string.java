public class Solution {
    public int findTheLongestBalancedSubstring(String s) {
        int maxLength = 0;
        int count0 = 0, count1 = 0;

        for (char c : s.toCharArray()) {
            if (c == '0') {
                if (count1 > 0) {
                    maxLength = Math.max(maxLength, Math.min(count0, count1) * 2);
                    count0 = 0;
                }
                count0++;
            } else {
                count1++;
            }
        }
        maxLength = Math.max(maxLength, Math.min(count0, count1) * 2);
        return maxLength;
    }
}