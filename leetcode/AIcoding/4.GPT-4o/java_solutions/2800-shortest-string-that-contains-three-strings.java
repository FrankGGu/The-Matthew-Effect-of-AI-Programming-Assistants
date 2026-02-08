import java.util.HashSet;
import java.util.Set;

public class Solution {
    public String findTheString(String[] words) {
        Set<String> wordSet = new HashSet<>();
        for (String word : words) {
            wordSet.add(word);
        }

        for (int len = 1; len <= 100; len++) {
            for (int i = 0; i < (1 << len); i++) {
                StringBuilder sb = new StringBuilder();
                for (int j = 0; j < len; j++) {
                    sb.append((i & (1 << j)) != 0 ? 'a' : 'b');
                }
                String candidate = sb.toString();
                if (!wordSet.contains(candidate) && !wordSet.contains(new StringBuilder(candidate).reverse().toString())) {
                    return candidate;
                }
            }
        }
        return "";
    }
}