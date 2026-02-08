public class Solution {

import java.util.*;

public class Solution {
    public boolean checkInclusion(String s1, String s2) {
        if (s1.length() > s2.length()) {
            return false;
        }

        int[] count = new int[26];
        for (int i = 0; i < s1.length(); i++) {
            count[s1.charAt(i) - 'a']++;
        }

        int left = 0;
        int right = 0;
        int length = s1.length();

        while (right < s2.length()) {
            count[s2.charAt(right) - 'a']--;
            if (right - left + 1 == length) {
                if (allZero(count)) {
                    return true;
                }
                count[s2.charAt(left) - 'a']++;
                left++;
            }
            right++;
        }

        return false;
    }

    private boolean allZero(int[] count) {
        for (int c : count) {
            if (c != 0) {
                return false;
            }
        }
        return true;
    }
}
}