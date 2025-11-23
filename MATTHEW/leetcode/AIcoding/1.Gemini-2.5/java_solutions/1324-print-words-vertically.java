import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<String> printVertically(String s) {
        String[] words = s.split(" ");
        int maxLength = 0;
        for (String word : words) {
            maxLength = Math.max(maxLength, word.length());
        }

        List<String> result = new ArrayList<>();
        for (int j = 0; j < maxLength; j++) {
            StringBuilder currentVerticalWord = new StringBuilder();
            for (int i = 0; i < words.length; i++) {
                if (j < words[i].length()) {
                    currentVerticalWord.append(words[i].charAt(j));
                } else {
                    currentVerticalWord.append(' ');
                }
            }
            String builtString = currentVerticalWord.toString();
            int trailingSpaceIndex = builtString.length() - 1;
            while (trailingSpaceIndex >= 0 && builtString.charAt(trailingSpaceIndex) == ' ') {
                trailingSpaceIndex--;
            }
            result.add(builtString.substring(0, trailingSpaceIndex + 1));
        }

        return result;
    }
}