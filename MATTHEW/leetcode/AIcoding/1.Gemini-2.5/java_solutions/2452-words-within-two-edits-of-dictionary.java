import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<String> twoEditWords(String[] queries, String[] dictionary) {
        List<String> result = new ArrayList<>();

        for (String queryWord : queries) {
            boolean foundMatch = false;
            for (String dictWord : dictionary) {
                if (getDiffCount(queryWord, dictWord) <= 2) {
                    foundMatch = true;
                    break;
                }
            }
            if (foundMatch) {
                result.add(queryWord);
            }
        }

        return result;
    }

    private int getDiffCount(String s1, String s2) {
        int count = 0;
        for (int i = 0; i < s1.length(); i++) {
            if (s1.charAt(i) != s2.charAt(i)) {
                count++;
            }
        }
        return count;
    }
}