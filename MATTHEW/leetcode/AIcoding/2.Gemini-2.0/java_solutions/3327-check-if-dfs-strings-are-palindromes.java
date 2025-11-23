import java.util.*;

class Solution {
    public boolean solve(String s0, String s1) {
        String s = s0 + s1;
        int n = s.length();
        for (int i = 0; i < n / 2; i++) {
            if (s.charAt(i) != s.charAt(n - 1 - i)) {
                return false;
            }
        }
        return true;
    }
}