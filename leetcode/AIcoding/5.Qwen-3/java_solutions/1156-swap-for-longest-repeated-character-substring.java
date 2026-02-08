public class Solution {

import java.util.*;

public class Solution {
    public int maxRepOptI(String text) {
        int n = text.length();
        int[] count = new int[26];
        for (char c : text.toCharArray()) {
            count[c - 'a']++;
        }

        int maxLen = 0;
        int i = 0;
        while (i < n) {
            char c = text.charAt(i);
            int j = i;
            while (j < n && text.charAt(j) == c) {
                j++;
            }
            int len = j - i;
            if (len > 1) {
                maxLen = Math.max(maxLen, len + (count[c - 'a'] > len ? 1 : 0));
            }
            i = j;
        }

        i = 0;
        while (i < n - 1) {
            char c1 = text.charAt(i);
            char c2 = text.charAt(i + 1);
            if (c1 != c2) {
                int j = i + 2;
                while (j < n && text.charAt(j) == c1) {
                    j++;
                }
                int len = j - (i + 2) + 1;
                if (len > 0) {
                    maxLen = Math.max(maxLen, len + 1 + (count[c1 - 'a'] > len + 1 ? 1 : 0));
                }
            }
            i++;
        }

        return maxLen;
    }
}
}