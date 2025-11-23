public class Solution {

import java.util.*;

public class Solution {
    public int[] stat(string s) {
        int[] result = new int[26];
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c >= 'a' && c <= 'z') {
                result[c - 'a']++;
            }
        }
        return result;
    }
}
}