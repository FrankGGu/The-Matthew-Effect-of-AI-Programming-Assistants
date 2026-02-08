import java.util.*;

public class Solution {
    public String sortString(String s) {
        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }

        StringBuilder result = new StringBuilder();
        while (result.length() < s.length()) {
            for (char c = 'a'; c <= 'z'; c++) {
                if (count[c - 'a'] > 0) {
                    result.append(c);
                    count[c - 'a']--;
                }
            }
            for (char c = 'z'; c >= 'a'; c--) {
                if (count[c - 'a'] > 0) {
                    result.append(c);
                    count[c - 'a']--;
                }
            }
        }

        return result.toString();
    }
}