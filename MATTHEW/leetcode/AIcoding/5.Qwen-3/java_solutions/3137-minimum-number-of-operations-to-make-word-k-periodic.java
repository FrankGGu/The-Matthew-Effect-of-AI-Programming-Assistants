public class Solution {

import java.util.*;

public class Solution {
    public long minimumOperationsToMakeKPeriodic(String word, long k) {
        Map<String, Long> freq = new HashMap<>();
        int n = word.length();
        for (int i = 0; i < n; i += k) {
            String sub = word.substring(i, Math.min(i + (int)k, n));
            freq.put(sub, freq.getOrDefault(sub, 0L) + 1);
        }
        long maxFreq = 0;
        for (long count : freq.values()) {
            if (count > maxFreq) {
                maxFreq = count;
            }
        }
        return (n / k) - maxFreq;
    }
}
}