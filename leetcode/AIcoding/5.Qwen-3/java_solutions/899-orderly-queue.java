public class Solution {

import java.util.*;

public class Solution {
    public String orderlyQueue(String s, int k) {
        if (k == 0) {
            return s;
        }
        if (k == 1) {
            String min = s;
            for (int i = 0; i < s.length(); i++) {
                String rotated = s.substring(i) + s.substring(0, i);
                if (rotated.compareTo(min) < 0) {
                    min = rotated;
                }
            }
            return min;
        } else {
            char[] chars = s.toCharArray();
            Arrays.sort(chars);
            return new String(chars);
        }
    }
}
}