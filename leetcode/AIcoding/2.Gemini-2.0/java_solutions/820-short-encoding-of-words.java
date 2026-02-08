import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

class Solution {
    public int minimumLengthEncoding(String[] words) {
        Set<String> s = new HashSet<>(Arrays.asList(words));
        for (String word : words) {
            for (int i = 1; i < word.length(); ++i) {
                s.remove(word.substring(i));
            }
        }

        int res = 0;
        for (String word : s) {
            res += word.length() + 1;
        }
        return res;
    }
}