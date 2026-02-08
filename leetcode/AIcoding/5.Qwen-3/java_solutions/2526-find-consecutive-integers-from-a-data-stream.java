public class Solution {

import java.util.*;

public class Solution {
    public List<String> findOcurrences(String text, String[] keywords, String[] responses) {
        List<String> result = new ArrayList<>();
        int n = text.length();
        int m = keywords.length;
        int k = responses.length;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                boolean match = true;
                for (int l = 0; l < keywords[j].length(); l++) {
                    if (i + l >= n || text.charAt(i + l) != keywords[j].charAt(l)) {
                        match = false;
                        break;
                    }
                }
                if (match) {
                    result.add(responses[j]);
                    i += keywords[j].length() - 1;
                    break;
                }
            }
        }

        return result;
    }
}
}