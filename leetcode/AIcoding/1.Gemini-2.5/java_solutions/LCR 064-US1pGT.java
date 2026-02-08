import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class MagicDictionary {

    private Map<Integer, List<String>> dictMap;

    public MagicDictionary() {
        dictMap = new HashMap<>();
    }

    public void buildDict(String[] dictionary) {
        for (String word : dictionary) {
            int len = word.length();
            dictMap.computeIfAbsent(len, k -> new ArrayList<>()).add(word);
        }
    }

    public boolean search(String searchWord) {
        int searchWordLen = searchWord.length();
        List<String> candidates = dictMap.get(searchWordLen);

        if (candidates == null || candidates.isEmpty()) {
            return false;
        }

        for (String dictWord : candidates) {
            int diffCount = 0;
            for (int i = 0; i < searchWordLen; i++) {
                if (searchWord.charAt(i) != dictWord.charAt(i)) {
                    diffCount++;
                }
                if (diffCount > 1) {
                    break; 
                }
            }
            if (diffCount == 1) {
                return true;
            }
        }
        return false;
    }
}