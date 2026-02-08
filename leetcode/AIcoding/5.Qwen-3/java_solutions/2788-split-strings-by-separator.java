public class Solution {

import java.util.*;

public class Solution {
    public List<String> splitWordsBySeparator(List<String> words, char separator) {
        List<String> result = new ArrayList<>();
        for (String word : words) {
            String[] parts = word.split(Pattern.quote(String.valueOf(separator)));
            for (String part : parts) {
                if (!part.isEmpty()) {
                    result.add(part);
                }
            }
        }
        return result;
    }
}
}