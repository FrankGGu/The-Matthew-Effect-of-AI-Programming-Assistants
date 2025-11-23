import java.util.*;

public class Solution {
    public List<String> twoEditWords(String[] queries, String[] dictionary) {
        List<String> result = new ArrayList<>();
        for (String query : queries) {
            for (String word : dictionary) {
                if (isWithinTwoEdits(query, word)) {
                    result.add(query);
                    break;
                }
            }
        }
        return result;
    }

    private boolean isWithinTwoEdits(String query, String word) {
        int edits = 0;
        for (int i = 0; i < query.length(); i++) {
            if (query.charAt(i) != word.charAt(i)) {
                edits++;
                if (edits > 2) return false;
            }
        }
        return edits <= 2;
    }
}