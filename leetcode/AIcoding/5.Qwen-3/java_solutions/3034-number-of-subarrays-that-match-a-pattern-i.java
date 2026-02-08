public class Solution {

import java.util.*;

public class Solution {
    public int numberOfSubarrays(String nums, String pattern) {
        int n = nums.length();
        int m = pattern.length();
        int count = 0;
        for (int i = 0; i <= n - m; i++) {
            boolean match = true;
            for (int j = 0; j < m; j++) {
                if (nums.charAt(i + j) != pattern.charAt(j)) {
                    match = false;
                    break;
                }
            }
            if (match) {
                count++;
            }
        }
        return count;
    }
}
}