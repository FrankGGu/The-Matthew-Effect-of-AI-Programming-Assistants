public class Solution {

import java.util.*;

public class Solution {
    public int longestDecomposition(String s) {
        int n = s.length();
        int left = 0, right = n - 1;
        int result = 0;
        while (left <= right) {
            int len = 0;
            while (left + len <= right && s.charAt(left) == s.charAt(right - len)) {
                len++;
            }
            if (len > 0) {
                result++;
                left += len;
                right -= len;
            } else {
                break;
            }
        }
        return result;
    }
}
}