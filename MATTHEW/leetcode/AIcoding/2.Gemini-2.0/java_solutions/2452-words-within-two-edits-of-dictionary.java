import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<String> twoEditWords(String[] queries, String[] dictionary) {
        List<String> result = new ArrayList<>();
        for (String query : queries) {
            for (String word : dictionary) {
                if (query.length() != word.length()) {
                    continue;
                }
                int diff = 0;
                for (int i = 0; i < query.length(); i++) {
                    if (query.charAt(i) != word.charAt(i)) {
                        diff++;
                    }
                }
                if (diff <= 2) {
                    result.add(query);
                    break;
                }
            }
        }
        return result;
    }
}