public class Solution {

import java.util.*;

public class Solution {
    public boolean checkInclusion(String s1, String s2) {
        if (s1.length() > s2.length()) {
            return false;
        }

        int[] count = new int[26];
        int len = s1.length();

        for (int i = 0; i < len; i++) {
            count[s1.charAt(i) - 'a']++;
            count[s2.charAt(i) - 'a']--;
        }

        if (areAllZero(count)) {
            return true;
        }

        for (int i = len; i < s2.length(); i++) {
            count[s2.charAt(i - len) - 'a']++;
            count[s2.charAt(i) - 'a']--;
            if (areAllZero(count)) {
                return true;
            }
        }

        return false;
    }

    private boolean areAllZero(int[] count) {
        for (int c : count) {
            if (c != 0) {
                return false;
            }
        }
        return true;
    }
}
}