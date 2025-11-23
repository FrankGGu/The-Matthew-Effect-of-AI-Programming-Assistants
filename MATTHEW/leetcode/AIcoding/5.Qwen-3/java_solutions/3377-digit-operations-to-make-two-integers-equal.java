public class Solution {

import java.util.*;

public class Solution {
    public int equalizeStrings(String s, String t) {
        int[] countS = new int[26];
        int[] countT = new int[26];

        for (char c : s.toCharArray()) {
            countS[c - 'a']++;
        }

        for (char c : t.toCharArray()) {
            countT[c - 'a']++;
        }

        int operations = 0;

        for (int i = 0; i < 26; i++) {
            if (countS[i] != countT[i]) {
                operations += Math.abs(countS[i] - countT[i]);
            }
        }

        return operations;
    }
}
}