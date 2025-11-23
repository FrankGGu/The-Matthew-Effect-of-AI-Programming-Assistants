import java.util.HashSet;
import java.util.Set;

class MagicDictionary {
    private Set<String> words;

    public MagicDictionary() {
        words = new HashSet<>();
    }

    public void buildDict(String[] dictionary) {
        for (String word : dictionary) {
            words.add(word);
        }
    }

    public boolean search(String searchWord) {
        for (String word : words) {
            if (word.length() == searchWord.length()) {
                int count = 0;
                for (int i = 0; i < word.length(); i++) {
                    if (word.charAt(i) != searchWord.charAt(i)) {
                        count++;
                    }
                    if (count > 1) {
                        break;
                    }
                }
                if (count == 1) {
                    return true;
                }
            }
        }
        return false;
    }
}