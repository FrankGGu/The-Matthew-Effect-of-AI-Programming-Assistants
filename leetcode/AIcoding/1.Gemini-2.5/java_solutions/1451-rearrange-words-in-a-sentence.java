import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {

    private static class WordInfo {
        String word;
        int originalIndex;

        WordInfo(String word, int originalIndex) {
            this.word = word;
            this.originalIndex = originalIndex;
        }
    }

    public String arrangeWords(String text) {
        String lowerText = text.toLowerCase();
        String[] wordsArray = lowerText.split(" ");

        List<WordInfo> wordInfos = new ArrayList<>();
        for (int i = 0; i < wordsArray.length; i++) {
            wordInfos.add(new WordInfo(wordsArray[i], i));
        }

        Collections.sort(wordInfos, (a, b) -> {
            if (a.word.length() != b.word.length()) {
                return a.word.length() - b.word.length();
            } else {
                return a.originalIndex - b.originalIndex;
            }
        });

        StringBuilder sb = new StringBuilder();
        for (WordInfo wi : wordInfos) {
            sb.append(wi.word).append(" ");
        }

        String result = sb.toString().trim();

        return Character.toUpperCase(result.charAt(0)) + result.substring(1);
    }
}