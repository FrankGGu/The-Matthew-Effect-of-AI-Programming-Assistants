import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Boolean> camelMatch(String[] queries, String pattern) {
        List<Boolean> result = new ArrayList<>();
        for (String query : queries) {
            result.add(isMatch(query, pattern));
        }
        return result;
    }

    private boolean isMatch(String query, String pattern) {
        int qPtr = 0;
        int pPtr = 0;

        while (qPtr < query.length()) {
            if (pPtr < pattern.length() && query.charAt(qPtr) == pattern.charAt(pPtr)) {
                pPtr++;
                qPtr++;
            } else if (Character.isUpperCase(query.charAt(qPtr))) {
                return false;
            } else {
                qPtr++;
            }
        }

        return pPtr == pattern.length();
    }
}