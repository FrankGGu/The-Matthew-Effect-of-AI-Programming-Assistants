public class Solution {

import java.util.*;

public class Solution {
    public boolean isValidWord(String word) {
        if (word.length() < 2) {
            return false;
        }
        Set<Character> vowels = new HashSet<>(Arrays.asList('a', 'e', 'i', 'o', 'u'));
        int vowelCount = 0;
        int consonantCount = 0;
        for (int i = 0; i < word.length(); i++) {
            char c = Character.toLowerCase(word.charAt(i));
            if (vowels.contains(c)) {
                vowelCount++;
                consonantCount = 0;
            } else {
                consonantCount++;
                vowelCount = 0;
            }
            if (consonantCount >= 3 || vowelCount >= 3) {
                return false;
            }
        }
        return true;
    }
}
}