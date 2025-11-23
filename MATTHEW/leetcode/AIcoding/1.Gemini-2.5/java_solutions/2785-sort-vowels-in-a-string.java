import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public String sortVowels(String s) {
        List<Character> vowels = new ArrayList<>();
        char[] charArray = s.toCharArray();

        for (char c : charArray) {
            if (isVowel(c)) {
                vowels.add(c);
            }
        }

        Collections.sort(vowels);

        int vowelIndex = 0;
        for (int i = 0; i < charArray.length; i++) {
            if (isVowel(charArray[i])) {
                charArray[i] = vowels.get(vowelIndex);
                vowelIndex++;
            }
        }

        return new String(charArray);
    }

    private boolean isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' ||
               c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U';
    }
}