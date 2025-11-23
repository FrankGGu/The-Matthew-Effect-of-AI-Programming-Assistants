public class Solution {

import java.util.*;

public class Solution {
    public List<Boolean> camelMatch(String[] queries, String pattern) {
        List<Boolean> result = new ArrayList<>();
        for (String query : queries) {
            result.add(match(query, pattern));
        }
        return result;
    }

    private boolean match(String query, String pattern) {
        int i = 0, j = 0;
        while (i < query.length()) {
            if (j < pattern.length() && query.charAt(i) == pattern.charAt(j)) {
                i++;
                j++;
            } else if (Character.isUpperCase(query.charAt(i))) {
                return false;
            } else {
                i++;
            }
        }
        return j == pattern.length();
    }
}
}