import java.util.Arrays;

class Solution {
    public String orderlyQueue(String s, int k) {
        if (k == 1) {
            String minString = s;
            int n = s.length();
            for (int i = 0; i < n; i++) {
                s = s.substring(1) + s.charAt(0);
                if (s.compareTo(minString) < 0) {
                    minString = s;
                }
            }
            return minString;
        } else {
            char[] chars = s.toCharArray();
            Arrays.sort(chars);
            return new String(chars);
        }
    }
}