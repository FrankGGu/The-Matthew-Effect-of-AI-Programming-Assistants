public class Solution {

import java.util.*;

class Solution {
    public int findSpecialInteger(String s) {
        int n = s.length();
        int count = 1;
        for (int i = 1; i < n; i++) {
            if (s.charAt(i) == s.charAt(i - 1)) {
                count++;
                if (count > n / 4) return s.charAt(i);
            } else {
                count = 1;
            }
        }
        return s.charAt(0);
    }
}
}