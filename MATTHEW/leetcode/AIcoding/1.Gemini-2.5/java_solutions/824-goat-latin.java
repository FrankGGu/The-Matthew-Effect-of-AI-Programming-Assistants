import java.util.HashSet;
import java.util.Set;

class Solution {
    public String toGoatLatin(String sentence) {
        Set<Character> vowels = new HashSet<>();
        vowels.add('a');
        vowels.add('e');
        vowels.add('i');
        vowels.add('o');
        vowels.add('u');
        vowels.add('A');
        vowels.add('E');
        vowels.add('I');
        vowels.add('O');
        vowels.add('U');

        String[] words = sentence.split(" ");
        StringBuilder result = new StringBuilder();
        StringBuilder suffixA = new StringBuilder("a");

        for (int i = 0; i < words.length; i++) {
            String word = words[i];
            char firstChar = word.charAt(0);

            if (vowels.contains(firstChar)) {
                result.append(word);
            } else {
                result.append(word.substring(1));
                result.append(firstChar);
            }
            result.append("ma");
            result.append(suffixA);

            if (i < words.length - 1) {
                result.append(" ");
            }
            suffixA.append('a');
        }

        return result.toString();
    }
}