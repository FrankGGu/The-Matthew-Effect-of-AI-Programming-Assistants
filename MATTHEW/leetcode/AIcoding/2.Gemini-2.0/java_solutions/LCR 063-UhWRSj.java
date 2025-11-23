import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

class Solution {
    public String replaceWords(List<String> dictionary, String sentence) {
        Set<String> dict = new HashSet<>(dictionary);
        String[] words = sentence.split(" ");
        StringBuilder sb = new StringBuilder();
        for (String word : words) {
            String replacement = word;
            for (int i = 1; i <= word.length(); i++) {
                String prefix = word.substring(0, i);
                if (dict.contains(prefix)) {
                    replacement = prefix;
                    break;
                }
            }
            sb.append(replacement).append(" ");
        }
        return sb.toString().trim();
    }
}