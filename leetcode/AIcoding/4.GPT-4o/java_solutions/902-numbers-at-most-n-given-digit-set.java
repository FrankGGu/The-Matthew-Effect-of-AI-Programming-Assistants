import java.util.HashSet;
import java.util.Set;

public class Solution {
    public int atMostNGivenDigitSet(String[] digits, int n) {
        String s = String.valueOf(n);
        int len = s.length();
        int count = 0;
        int m = digits.length;

        for (int i = 1; i < len; i++) {
            count += Math.pow(m, i);
        }

        for (int i = 0; i < len; i++) {
            boolean hasSamePrefix = false;
            for (String digit : digits) {
                if (digit.charAt(0) < s.charAt(i)) {
                    count += Math.pow(m, len - i - 1);
                } else if (digit.charAt(0) == s.charAt(i)) {
                    hasSamePrefix = true;
                    break;
                }
            }
            if (!hasSamePrefix) {
                break;
            }
        }

        return count + 1;
    }
}