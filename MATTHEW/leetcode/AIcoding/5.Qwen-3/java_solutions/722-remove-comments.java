public class Solution {

import java.util.*;

public class Solution {
    public List<String> removeComments(String[] source) {
        List<String> result = new ArrayList<>();
        boolean inBlock = false;
        StringBuilder line = new StringBuilder();

        for (String s : source) {
            int i = 0;
            while (i < s.length()) {
                if (!inBlock) {
                    if (i + 1 < s.length() && s.charAt(i) == '/' && s.charAt(i + 1) == '*') {
                        inBlock = true;
                        i += 2;
                    } else if (i + 1 < s.length() && s.charAt(i) == '/' && s.charAt(i + 1) == '/') {
                        break;
                    } else {
                        line.append(s.charAt(i));
                        i++;
                    }
                } else {
                    if (i + 1 < s.length() && s.charAt(i) == '*' && s.charAt(i + 1) == '/') {
                        inBlock = false;
                        i += 2;
                    } else {
                        i++;
                    }
                }
            }
            if (!inBlock) {
                result.add(line.toString());
                line = new StringBuilder();
            }
        }

        return result;
    }
}
}