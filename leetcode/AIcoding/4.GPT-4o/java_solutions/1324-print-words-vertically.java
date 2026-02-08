import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<String> printVertically(String s) {
        String[] words = s.split(" ");
        int maxLength = 0;
        for (String word : words) {
            maxLength = Math.max(maxLength, word.length());
        }

        List<String> result = new ArrayList<>();
        for (int i = 0; i < maxLength; i++) {
            StringBuilder sb = new StringBuilder();
            for (String word : words) {
                if (i < word.length()) {
                    sb.append(word.charAt(i));
                } else {
                    sb.append(" ");
                }
            }
            result.add(sb.toString().replaceAll(" +$", ""));
        }
        return result;
    }
}