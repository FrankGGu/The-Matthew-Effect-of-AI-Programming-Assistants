import java.util.List;
import java.util.ArrayList;

public class Solution {
    public List<Boolean> camelMatch(String[] queries, String pattern) {
        List<Boolean> result = new ArrayList<>();
        for (String query : queries) {
            result.add(matches(query, pattern));
        }
        return result;
    }

    private boolean matches(String query, String pattern) {
        int i = 0, j = 0;
        while (i < query.length() && j < pattern.length()) {
            if (query.charAt(i) == pattern.charAt(j)) {
                j++;
            } else if (Character.isUpperCase(query.charAt(i))) {
                return false;
            }
            i++;
        }
        while (j < pattern.length()) {
            if (Character.isUpperCase(pattern.charAt(j))) {
                return false;
            }
            j++;
        }
        return true;
    }
}