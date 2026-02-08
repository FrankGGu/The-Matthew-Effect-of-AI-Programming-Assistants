import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<String> findWords(String[] words, char ch) {
        List<String> result = new ArrayList<>();
        for (String word : words) {
            if (word.indexOf(ch) != -1) {
                result.add(word);
            }
        }
        return result;
    }
}