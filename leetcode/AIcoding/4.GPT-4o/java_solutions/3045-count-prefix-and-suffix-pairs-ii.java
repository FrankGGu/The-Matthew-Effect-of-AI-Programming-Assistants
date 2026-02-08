import java.util.HashSet;
import java.util.Set;

class Solution {
    public int countPrefixAndSuffixPairs(String[] words) {
        Set<String> set = new HashSet<>();
        int count = 0;

        for (String word : words) {
            set.add(word);
        }

        for (String word : words) {
            String prefix = word;
            String suffix = word;

            for (int i = 0; i < word.length(); i++) {
                prefix = prefix.substring(0, i);
                suffix = suffix.substring(i);

                if (set.contains(prefix) && set.contains(suffix) && !prefix.equals(suffix)) {
                    count++;
                }
            }
        }

        return count;
    }
}