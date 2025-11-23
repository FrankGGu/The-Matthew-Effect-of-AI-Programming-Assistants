import java.util.HashSet;
import java.util.Set;

class Solution {
    public int maximumNumberOfStringPairs(String[] words) {
        int count = 0;
        Set<String> seen = new HashSet<>();

        for (String word : words) {
            String reversedWord = new StringBuilder(word).reverse().toString();

            if (seen.contains(reversedWord)) {
                count++;
                seen.remove(reversedWord);
            } else {
                seen.add(word);
            }
        }

        return count;
    }
}