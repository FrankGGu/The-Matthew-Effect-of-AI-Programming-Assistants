public class Solution {

import java.util.*;

public class Solution {
    public String recoverOriginal(String s) {
        StringBuilder result = new StringBuilder();
        int i = 0;
        while (i < s.length()) {
            char c = s.charAt(i);
            if (c >= '0' && c <= '9') {
                int num = 0;
                while (i < s.length() && s.charAt(i) >= '0' && s.charAt(i) <= '9') {
                    num = num * 10 + (s.charAt(i) - '0');
                    i++;
                }
                char ch = s.charAt(i);
                for (int j = 0; j < num; j++) {
                    result.append(ch);
                }
                i++;
            } else {
                result.append(c);
                i++;
            }
        }
        return result.toString();
    }
}
}