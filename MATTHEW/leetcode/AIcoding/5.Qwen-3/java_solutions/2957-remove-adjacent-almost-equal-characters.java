public class Solution {

import java.util.*;

public class Solution {
    public int removeAlmostEqualCharacters(String s) {
        int n = s.length();
        int count = 0;
        for (int i = 0; i < n - 1; ) {
            if (Math.abs(s.charAt(i) - s.charAt(i + 1)) <= 1) {
                count++;
                i += 2;
            } else {
                i++;
            }
        }
        return n - count;
    }
}
}