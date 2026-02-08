public class Solution {

import java.util.*;

public class Solution {
    public String sortString(String s) {
        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }

        StringBuilder result = new StringBuilder();
        while (true) {
            boolean hasChar = false;
            for (int i = 0; i < 26; i++) {
                if (count[i] > 0) {
                    result.append((char) ('a' + i));
                    count[i]--;
                    hasChar = true;
                }
            }
            for (int i = 25; i >= 0; i--) {
                if (count[i] > 0) {
                    result.append((char) ('a' + i));
                    count[i]--;
                    hasChar = true;
                }
            }
            if (!hasChar) break;
        }
        return result.toString();
    }
}
}