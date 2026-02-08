import java.util.HashSet;
import java.util.Set;

class MagicDictionary {

    private String[] words;

    public MagicDictionary() {

    }

    public void buildDict(String[] dictionary) {
        this.words = dictionary;
    }

    public boolean search(String searchWord) {
        for (String word : words) {
            if (word.length() == searchWord.length()) {
                int diff = 0;
                for (int i = 0; i < word.length(); i++) {
                    if (word.charAt(i) != searchWord.charAt(i)) {
                        diff++;
                    }
                }
                if (diff == 1) {
                    return true;
                }
            }
        }
        return false;
    }
}