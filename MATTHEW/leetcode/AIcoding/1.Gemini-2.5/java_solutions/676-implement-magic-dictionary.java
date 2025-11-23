import java.util.HashSet;
import java.util.Set;

class MagicDictionary {

    private Set<String> dict;

    public MagicDictionary() {
        dict = new HashSet<>();
    }

    public void buildDict(String[] dictionary) {
        for (String word : dictionary) {
            dict.add(word);
        }
    }

    public boolean search(String searchWord) {
        for (String dictWord : dict) {
            if (dictWord.length() != searchWord.length()) {
                continue;
            }

            int diffCount = 0;
            for (int i = 0; i < dictWord.length(); i++) {
                if (dictWord.charAt(i) != searchWord.charAt(i)) {
                    diffCount++;
                }
            }

            if (diffCount == 1) {
                return true;
            }
        }
        return false;
    }
}