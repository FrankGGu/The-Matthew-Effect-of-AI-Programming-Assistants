import java.util.*;

class Solution {
    public String extractSpell(String s) {
        Set<Character> vowels = new HashSet<>(Arrays.asList('a', 'e', 'i', 'o', 'u'));
        StringBuilder sb = new StringBuilder();
        for (char c : s.toCharArray()) {
            if (Character.isLetter(c) && !vowels.contains(Character.toLowerCase(c))) {
                sb.append(c);
            }
        }
        return sb.toString();
    }
}