import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public long[] sumPrefixScores(String[] words) {
        int n = words.length;
        long[] result = new long[n];
        Map<String, Long> prefixSum = new HashMap<>();

        for (String word : words) {
            for (int i = 1; i <= word.length(); i++) {
                String prefix = word.substring(0, i);
                prefixSum.put(prefix, prefixSum.getOrDefault(prefix, 0L) + word.length());
            }
        }

        for (int i = 0; i < n; i++) {
            result[i] = prefixSum.get(words[i]);
        }

        return result;
    }
}