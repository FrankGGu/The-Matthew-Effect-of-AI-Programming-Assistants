public class Solution {

import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<String> fullJustify(String[] words, int maxWidth) {
        List<String> result = new ArrayList<>();
        int n = words.length;
        int i = 0;
        while (i < n) {
            int j = i;
            int totalLength = 0;
            while (j < n && totalLength + words[j].length() <= maxWidth) {
                totalLength += words[j].length() + 1;
                j++;
            }
            int numWords = j - i;
            int spaceCount = maxWidth - (totalLength - numWords);
            StringBuilder sb = new StringBuilder();
            if (numWords == 1) {
                sb.append(words[i]);
                for (int k = 0; k < spaceCount; k++) {
                    sb.append(" ");
                }
            } else {
                int spaceBetween = spaceCount / (numWords - 1);
                int extraSpace = spaceCount % (numWords - 1);
                for (int k = i; k < j; k++) {
                    sb.append(words[k]);
                    if (k < j - 1) {
                        for (int l = 0; l < spaceBetween; l++) {
                            sb.append(" ");
                        }
                        if (extraSpace > 0) {
                            sb.append(" ");
                            extraSpace--;
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
}