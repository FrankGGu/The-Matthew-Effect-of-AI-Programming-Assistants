public class Solution {

import java.util.HashSet;
import java.util.Set;

public class UniqueMorseRepresentations {
    public int uniqueMorseRepresentations(String[] words) {
        String[] morseCodes = {".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.",
                               "---",".--.","--.-",".-.","...","-","..-","...-",".--","-..","-.","---",".--",
                               "-.--","--."};
        Set<String> set = new HashSet<>();
        for (String word : words) {
            StringBuilder sb = new StringBuilder();
            for (char c : word.toCharArray()) {
                sb.append(morseCodes[c - 'a']);
            }
            set.add(sb.toString());
        }
        return set.size();
    }
}
}