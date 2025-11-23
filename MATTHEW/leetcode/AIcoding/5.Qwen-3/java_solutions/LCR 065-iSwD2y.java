public class Solution {

import java.util.*;

public class Solution {
    public int minimumLengthEncoding(String[] words) {
        Set<String> wordSet = new HashSet<>(Arrays.asList(words));
        for (String word : words) {
            for (int i = 1; i < word.length(); i++) {
                wordSet.remove(word.substring(i));
            }
        }
        int length = 0;
        for (String word : wordSet) {
            length += word.length() + 1;
        }
        return length;
    }
}
}