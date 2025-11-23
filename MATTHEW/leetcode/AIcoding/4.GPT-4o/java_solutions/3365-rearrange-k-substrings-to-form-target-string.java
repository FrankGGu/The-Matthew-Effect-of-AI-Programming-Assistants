import java.util.*;

class Solution {
    public boolean canRearrange(String s, String target) {
        if (s.length() < target.length()) return false;

        int[] countS = new int[26];
        int[] countTarget = new int[26];

        for (char c : s.toCharArray()) {
            countS[c - 'a']++;
        }

        for (char c : target.toCharArray()) {
            countTarget[c - 'a']++;
        }

        for (int i = 0; i < 26; i++) {
            if (countTarget[i] > countS[i]) {
                return false;
            }
        }

        return true;
    }
}