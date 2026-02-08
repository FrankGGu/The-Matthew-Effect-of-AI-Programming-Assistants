public class Solution {

import java.util.*;

public class Solution {
    public String findSmallestPalindrome(String s) {
        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }

        StringBuilder left = new StringBuilder();
        StringBuilder right = new StringBuilder();
        Character middle = null;

        for (int i = 0; i < 26; i++) {
            if (count[i] % 2 == 1) {
                if (middle == null) {
                    middle = (char) ('a' + i);
                } else {
                    return "NO";
                }
            }
            for (int j = 0; j < count[i] / 2; j++) {
                left.append((char) ('a' + i));
                right.append((char) ('a' + i));
            }
        }

        if (middle != null) {
            left.append(middle);
        }

        return left.toString() + right.reverse().toString();
    }
}
}