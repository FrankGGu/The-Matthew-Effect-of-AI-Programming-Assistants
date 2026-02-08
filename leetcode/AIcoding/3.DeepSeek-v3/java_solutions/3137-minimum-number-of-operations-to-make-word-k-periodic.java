import java.util.HashMap;
import java.util.Map;

class Solution {
    public int minimumOperationsToMakeKPeriodic(String word, int k) {
        Map<String, Integer> freq = new HashMap<>();
        int maxFreq = 0;
        int n = word.length();
        for (int i = 0; i <= n - k; i += k) {
            String segment = word.substring(i, i + k);
            freq.put(segment, freq.getOrDefault(segment, 0) + 1);
            maxFreq = Math.max(maxFreq, freq.get(segment));
        }
        return (n / k) - maxFreq;
    }
}