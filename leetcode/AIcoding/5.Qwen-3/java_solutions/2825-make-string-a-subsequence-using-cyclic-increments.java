public class Solution {

import java.util.*;

public class Solution {
    public boolean canMakeSubsequence(String source, String target) {
        int i = 0, j = 0;
        while (i < source.length() && j < target.length()) {
            char sChar = source.charAt(i);
            char tChar = target.charAt(j);
            if (sChar == tChar) {
                i++;
                j++;
            } else {
                char nextChar = (char) ((sChar - 'a' + 1) % 26 + 'a');
                if (nextChar == tChar) {
                    i++;
                    j++;
                } else {
                    i++;
                }
            }
        }
        return j == target.length();
    }
}
}