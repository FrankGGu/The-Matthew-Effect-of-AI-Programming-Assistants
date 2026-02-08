import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

class Solution {
    public int minimumLengthEncoding(String[] words) {
        Set<String> set = new HashSet<>(Arrays.asList(words));

        for (String word : words) {
            for (int i = 1; i < word.length(); i++) {
                String suffix = word.substring(i);
                if (set.contains(suffix)) {
                    set.remove(suffix);
                }
            }
        }

        int totalLength = 0;
        for (String word : set) {
            totalLength += word.length() + 1;
        }

        return totalLength;
    }
}