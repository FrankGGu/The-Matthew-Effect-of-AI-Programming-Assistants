import java.util.Arrays;
import java.util.Collections;

class Solution {
    public long smallestNumber(long num) {
        if (num == 0) {
            return 0;
        }

        boolean isNegative = num < 0;
        long absNum = Math.abs(num);
        char[] s = String.valueOf(absNum).toCharArray();

        if (isNegative) {
            Arrays.sort(s);
            StringBuilder sb = new StringBuilder(new String(s));
            sb.reverse();
            return -Long.parseLong(sb.toString());
        } else {
            Arrays.sort(s);
            if (s[0] == '0') {
                int i = 0;
                while (i < s.length && s[i] == '0') {
                    i++;
                }
                char temp = s[0];
                s[0] = s[i];
                s[i] = temp;
            }
            return Long.parseLong(new String(s));
        }
    }
}