import java.util.HashSet;
import java.util.Set;

class Solution {
    public int canBeTypedWords(String text, String brokenLetters) {
        Set<Character> brokenChars = new HashSet<>();
        for (char c : brokenLetters.toCharArray()) {
            brokenChars.add(c);
        }

        String[] words = text.split(" ");
        int typeableWordsCount = 0;

        for (String word : words) {
            boolean canTypeWord = true;
            for (char c : word.toCharArray()) {
                if (brokenChars.contains(c)) {
                    canTypeWord = false;
                    break;
                }
            }
            if (canTypeWord) {
                typeableWordsCount++;
            }
        }

        return typeableWordsCount;
    }
}