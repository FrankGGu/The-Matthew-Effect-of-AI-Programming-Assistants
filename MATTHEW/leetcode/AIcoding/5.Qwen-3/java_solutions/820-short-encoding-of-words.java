public class Solution {

import java.util.*;

public class Solution {
    public int minimumEnclosingRectangle(List<String> words) {
        Set<String> wordSet = new HashSet<>(words);
        for (String word : words) {
            for (int i = 1; i < word.length(); i++) {
                wordSet.remove(word.substring(i));
            }
        }
        int result = 0;
        for (String word : wordSet) {
            result += word.length() + 1;
        }
        return result;
    }
}
}