import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

class Solution {
    public String longestWord(String[] words) {
        Arrays.sort(words);
        Set<String> builtWords = new HashSet<>();
        String longestWord = "";

        for (String word : words) {
            if (word.length() == 1 || builtWords.contains(word.substring(0, word.length() - 1))) {
                builtWords.add(word);
                if (word.length() > longestWord.length()) {
                    longestWord = word;
                }
            }
        }
        return longestWord;
    }
}