public class Solution {

import java.util.*;

public class Solution {
    public List<String> maxFreq(String s, int[] parts) {
        int maxFreq = 0;
        Map<String, Integer> freqMap = new HashMap<>();
        Set<String> uniqueSubstrings = new HashSet<>();

        for (int part : parts) {
            for (int i = 0; i <= s.length() - part; i++) {
                String sub = s.substring(i, i + part);
                freqMap.put(sub, freqMap.getOrDefault(sub, 0) + 1);
                uniqueSubstrings.add(sub);
            }
        }

        for (String sub : uniqueSubstrings) {
            maxFreq = Math.max(maxFreq, freqMap.get(sub));
        }

        List<String> result = new ArrayList<>();
        for (String sub : uniqueSubstrings) {
            if (freqMap.get(sub) == maxFreq) {
                result.add(sub);
            }
        }

        return result;
    }
}
}