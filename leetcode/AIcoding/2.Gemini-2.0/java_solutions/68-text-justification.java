import java.util.ArrayList;
import java.util.List;

public class TextJustification {
    public List<String> fullJustify(String[] words, int maxWidth) {
        List<String> result = new ArrayList<>();
        int i = 0;
        while (i < words.length) {
            int j = i;
            int lineLength = 0;
            while (j < words.length && lineLength + words[j].length() + (j - i) <= maxWidth) {
                lineLength += words[j].length();
                j++;
            }

            int numWords = j - i;

            if (numWords == 1 || j == words.length) {
                StringBuilder sb = new StringBuilder();
                for (int k = i; k < j; k++) {
                    sb.append(words[k]);
                    if (k < j - 1) {
                        sb.append(" ");
                    }
                }
                while (sb.length() < maxWidth) {
                    sb.append(" ");
                }
                result.add(sb.toString());
            } else {
                int numSpaces = maxWidth - lineLength;
                int spacesBetweenWords = numSpaces / (numWords - 1);
                int extraSpaces = numSpaces % (numWords - 1);

                StringBuilder sb = new StringBuilder();
                for (int k = i; k < j; k++) {
                    sb.append(words[k]);
                    if (k < j - 1) {
                        for (int l = 0; l < spacesBetweenWords; l++) {
                            sb.append(" ");
                        }
                        if (extraSpaces > 0) {
                            sb.append(" ");
                            extraSpaces--;
                        }
                    }
                }
                result.add(sb.toString());
            }
            i = j;
        }
        return result;
    }
}