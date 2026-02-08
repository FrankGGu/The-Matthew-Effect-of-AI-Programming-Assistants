public class Solution {

import java.util.*;

public class Solution {
    public String findOriginalString(String s) {
        int n = s.length();
        StringBuilder result = new StringBuilder();
        int i = 0;
        while (i < n) {
            int j = i;
            while (j < n && Character.isDigit(s.charAt(j))) {
                j++;
            }
            if (j > i) {
                int k = Integer.parseInt(s.substring(i, j));
                i = j;
                for (int m = 0; m < k; m++) {
                    result.append(s.charAt(i));
                }
                i++;
            } else {
                result.append(s.charAt(i));
                i++;
            }
        }
        return result.toString();
    }
}
}