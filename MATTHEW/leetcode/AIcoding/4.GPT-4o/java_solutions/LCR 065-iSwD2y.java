import java.util.HashSet;

public class Solution {
    public int minimumLengthEncoding(String[] words) {
        HashSet<String> set = new HashSet<>();
        for (String word : words) {
            set.add(word);
        }
        for (String word : words) {
            for (int i = 1; i < word.length(); i++) {
                set.remove(word.substring(i));
            }
        }
        int length = 0;
        for (String word : set) {
            length += word.length() + 1;
        }
        return length;
    }
}