import java.util.ArrayList;
import java.util.List;

class Solution {
    public String reorderSpaces(String text) {
        List<String> words = new ArrayList<>();
        int spaceCount = 0;
        StringBuilder currentWord = new StringBuilder();

        for (char c : text.toCharArray()) {
            if (c == ' ') {
                spaceCount++;
                if (currentWord.length() > 0) {
                    words.add(currentWord.toString());
                    currentWord.setLength(0);
                }
            } else {
                currentWord.append(c);
            }
        }
        if (currentWord.length() > 0) {
            words.add(currentWord.toString());
        }

        int numWords = words.size();
        int spacesPerGap;
        int remainingSpaces;

        if (numWords == 1) {
            spacesPerGap = 0;
            remainingSpaces = spaceCount;
        } else {
            spacesPerGap = spaceCount / (numWords - 1);
            remainingSpaces = spaceCount % (numWords - 1);
        }

        StringBuilder result = new StringBuilder();
        String gapSpace = " ".repeat(spacesPerGap);
        String remainingSpaceStr = " ".repeat(remainingSpaces);

        for (int i = 0; i < numWords; i++) {
            result.append(words.get(i));
            if (i < numWords - 1) {
                result.append(gapSpace);
            }
        }
        result.append(remainingSpaceStr);

        return result.toString();
    }
}