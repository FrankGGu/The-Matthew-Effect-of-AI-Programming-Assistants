public class Solution {

import java.util.*;

public class Solution {
    public String longestCommonPrefix(List<String> strings) {
        if (strings == null || strings.size() == 0) return "";
        String prefix = strings.get(0);
        for (int i = 1; i < strings.size(); i++) {
            while (strings.get(i).indexOf(prefix) != 0) {
                prefix = prefix.substring(0, prefix.length() - 1);
                if (prefix.isEmpty()) return "";
            }
        }
        return prefix;
    }
}
}