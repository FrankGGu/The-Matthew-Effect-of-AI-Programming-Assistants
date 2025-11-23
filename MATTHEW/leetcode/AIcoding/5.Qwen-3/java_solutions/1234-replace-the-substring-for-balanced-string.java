public class Solution {

import java.util.*;

public class Solution {
    public int replaceSubstringForBalancedString(String s) {
        int n = s.length();
        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }
        int res = n;
        int left = 0;
        for (int right = 0; right < n; right++) {
            count[s.charAt(right) - 'a']--;
            while (left <= right && count[s.charAt(right) - 'a'] <= n / 4) {
                int len = right - left + 1;
                if (len < res) {
                    res = len;
                }
                count[s.charAt(left) - 'a']++;
                left++;
            }
        }
        return res;
    }
}
}