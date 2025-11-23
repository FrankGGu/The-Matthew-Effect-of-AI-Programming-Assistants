public class Solution {

import java.util.*;

public class Solution {
    public boolean matchReplacement(String s, String t, char[] charMap) {
        int n = s.length();
        int m = t.length();
        if (m > n) return false;

        for (int i = 0; i <= n - m; i++) {
            boolean match = true;
            for (int j = 0; j < m; j++) {
                char sc = s.charAt(i + j);
                char tc = t.charAt(j);
                if (sc != tc && charMap[tc - 'a'] != sc) {
                    match = false;
                    break;
                }
            }
            if (match) return true;
        }
        return false;
    }
}
}