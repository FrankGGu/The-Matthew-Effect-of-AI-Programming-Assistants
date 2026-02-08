public class Solution {
    public int maxPower(String s) {
        if (s == null || s.length() == 0) {
            return 0;
        }

        int max = 1;
        int current = 1;

        for (int i = 1; i < s.length(); i++) {
            if (s.charAt(i) == s.charAt(i - 1)) {
                current++;
                if (current > max) {
                    max = current;
                }
            } else {
                current = 1;
            }
        }

        return max;
    }
}