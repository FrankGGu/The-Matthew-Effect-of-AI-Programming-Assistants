import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public String sortVowels(String s) {
        List<Character> vowels = new ArrayList<>();
        for (char c : s.toCharArray()) {
            if ("AEIOUaeiou".indexOf(c) != -1) {
                vowels.add(c);
            }
        }
        Collections.sort(vowels);
        StringBuilder sb = new StringBuilder();
        int vowelIndex = 0;
        for (char c : s.toCharArray()) {
            if ("AEIOUaeiou".indexOf(c) != -1) {
                sb.append(vowels.get(vowelIndex++));
            } else {
                sb.append(c);
            }
        }
        return sb.toString();
    }
}