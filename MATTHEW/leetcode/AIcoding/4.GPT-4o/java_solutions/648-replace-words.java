import java.util.Set;
import java.util.HashSet;

class Solution {
    public String replaceWords(List<String> dict, String sentence) {
        Set<String> prefixes = new HashSet<>(dict);
        String[] words = sentence.split(" ");
        StringBuilder result = new StringBuilder();

        for (String word : words) {
            String replacement = word;
            for (int i = 1; i <= word.length(); i++) {
                if (prefixes.contains(word.substring(0, i))) {
                    replacement = word.substring(0, i);
                    break;
                }
            }
            result.append(replacement).append(" ");
        }

        return result.toString().trim();
    }
}