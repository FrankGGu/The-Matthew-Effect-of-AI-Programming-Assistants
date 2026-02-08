import java.util.*;

public class Solution {
    public String replaceWords(List<String> dict, String sentence) {
        Set<String> dictionary = new HashSet<>(dict);
        String[] words = sentence.split(" ");
        for (int i = 0; i < words.length; i++) {
            for (String root : dictionary) {
                if (words[i].startsWith(root)) {
                    words[i] = root;
                    break;
                }
            }
        }
        return String.join(" ", words);
    }
}