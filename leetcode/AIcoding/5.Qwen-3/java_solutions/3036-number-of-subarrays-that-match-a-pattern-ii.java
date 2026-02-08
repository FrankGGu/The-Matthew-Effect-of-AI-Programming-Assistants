public class Solution {

import java.util.*;

public class Solution {
    public int numberOfMatchingPatterns(String[] patterns, String s) {
        int n = s.length();
        int m = patterns.length;
        int result = 0;

        for (int i = 0; i < m; i++) {
            String pattern = patterns[i];
            int len = pattern.length();
            if (len > n) continue;

            boolean match = true;
            for (int j = 1; j < len; j++) {
                char prevChar = s.charAt(j - 1);
                char currChar = s.charAt(j);
                char prevPat = pattern.charAt(j - 1);
                char currPat = pattern.charAt(j);

                if ((prevChar == currChar && prevPat != currPat) || (prevChar != currChar && prevPat == currPat)) {
                    match = false;
                    break;
                }
            }

            if (match) {
                result++;
            }
        }

        return result;
    }
}
}