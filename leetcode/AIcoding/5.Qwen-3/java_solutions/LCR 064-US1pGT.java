public class Solution {

import java.util.*;

public class MagicDictionary {
    private List<String> words;

    public MagicDictionary() {
        words = new ArrayList<>();
    }

    public void buildDict(String[] dictionary) {
        words.clear();
        for (String word : dictionary) {
            words.add(word);
        }
    }

    public boolean search(String target) {
        for (String word : words) {
            if (word.length() != target.length()) {
                continue;
            }
            int diff = 0;
            for (int i = 0; i < word.length(); i++) {
                if (word.charAt(i) != target.charAt(i)) {
                    diff++;
                    if (diff > 1) {
                        break;
                    }
                }
            }
            if (diff == 1) {
                return true;
            }
        }
        return false;
    }
}
}