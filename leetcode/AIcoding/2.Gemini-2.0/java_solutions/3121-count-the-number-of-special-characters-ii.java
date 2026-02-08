import java.util.HashSet;
import java.util.Set;

class Solution {
    public int countSpecialCharacters(String s) {
        Set<Character> specialChars = new HashSet<>();
        for (char c : s.toCharArray()) {
            if (!Character.isLetterOrDigit(c)) {
                specialChars.add(c);
            }
        }
        return specialChars.size();
    }
}