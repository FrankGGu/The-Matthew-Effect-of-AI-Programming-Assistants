import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<String> fullJustify(String[] words, int maxWidth) {
        List<String> result = new ArrayList<>();
        int i = 0;

        while (i < words.length) {
            int currentLineLength = 0;
            int j = i;

            while (j < words.length && (currentLineLength + words[j].length() + (j - i) <= maxWidth)) {
                currentLineLength += words[j].length();
                j++;
            }

            int numWordsInLine = j - i;
            int totalLengthOfWords = currentLineLength;
            int totalSpacesNeeded = maxWidth - totalLengthOfWords;

            StringBuilder sb = new StringBuilder();

            if (numWordsInLine == 1 || j == words.length) { // Last line or single word line
                for (int k = i; k < j; k++) {
                    sb.append(words[k]);
                    if (k < j - 1) {
                        sb.append(" ");
                    }
                }
                while (sb.length() < maxWidth) {
                    sb.append(" ");
                }
            } else { // Regular justified line with multiple words
                int numGaps = numWordsInLine - 1;
                int baseSpacesPerGap = totalSpacesNeeded / numGaps;
                int extraSpaces = totalSpacesNeeded % numGaps;

                for (int k = i; k < j; k++) {
                    sb.append(words[k]);
                    if (k < j - 1) { // If not the last word in the line
                        for (int s = 0; s < baseSpacesPerGap; s++) {
                            sb.append(" ");
                        }
                        if (extraSpaces > 0) {
                            sb.append(" ");
                            extraSpaces--;
                        }
                    }
                }
            }
            result.add(sb.toString());
            i = j;
        }

        return result;
    }
}