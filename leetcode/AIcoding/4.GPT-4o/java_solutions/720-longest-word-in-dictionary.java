import java.util.Set;
import java.util.HashSet;

public class Solution {
    public String longestWord(String[] words) {
        Set<String> wordSet = new HashSet<>();
        for (String word : words) {
            wordSet.add(word);
        }

        String longest = "";
        for (String word : words) {
            if ((word.length() > longest.length()) || 
                (word.length() == longest.length() && word.compareTo(longest) < 0)) {
                boolean canBuild = true;
                for (int i = 1; i < word.length(); i++) {
                    if (!wordSet.contains(word.substring(0, i))) {
                        canBuild = false;
                        break;
                    }
                }
                if (canBuild) {
                    longest = word;
                }
            }
        }
        return longest;
    }
}