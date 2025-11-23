import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

class Solution {
    public String replaceWords(List<String> dictionary, String sentence) {
        Set<String> dictSet = new HashSet<>(dictionary);
        String[] words = sentence.split(" ");
        StringBuilder result = new StringBuilder();

        for (String word : words) {
            String replacement = word;
            for (int i = 1; i <= word.length(); i++) {
                String prefix = word.substring(0, i);
                if (dictSet.contains(prefix)) {
                    replacement = prefix;
                    break;
                }
            }
            result.append(replacement).append(" ");
        }

        return result.toString().trim();
    }
}