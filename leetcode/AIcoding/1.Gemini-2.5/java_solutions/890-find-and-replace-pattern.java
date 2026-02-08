import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public List<String> findAndReplacePattern(String[] words, String pattern) {
        List<String> result = new ArrayList<>();
        for (String word : words) {
            if (matches(word, pattern)) {
                result.add(word);
            }
        }
        return result;
    }

    private boolean matches(String word, String pattern) {
        if (word.length() != pattern.length()) {
            return false;
        }

        Map<Character, Character> pToW = new HashMap<>();
        Map<Character, Character> wToP = new HashMap<>();

        for (int i = 0; i < word.length(); i++) {
            char pc = pattern.charAt(i);
            char wc = word.charAt(i);

            if (pToW.containsKey(pc)) {
                if (pToW.get(pc) != wc) {
                    return false;
                }
            } else {
                if (wToP.containsKey(wc)) {
                    return false;
                }
                pToW.put(pc, wc);
                wToP.put(wc, pc);
            }
        }
        return true;
    }
}