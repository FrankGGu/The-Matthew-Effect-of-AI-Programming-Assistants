public class Solution {

import java.util.*;

public class Solution {
    public String finalString(String s) {
        StringBuilder result = new StringBuilder();
        for (char c : s.toCharArray()) {
            if (c == '#') {
                if (result.length() > 0) {
                    result.setLength(result.length() - 1);
                }
            } else {
                result.append(c);
            }
        }
        return result.toString();
    }
}
}