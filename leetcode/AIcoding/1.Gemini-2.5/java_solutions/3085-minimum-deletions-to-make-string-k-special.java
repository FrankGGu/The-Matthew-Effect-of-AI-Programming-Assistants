import java.util.HashMap;
import java.util.Map;

class Solution {
    public int minimumDeletions(String s, int k) {
        Map<Character, Integer> freqMap = new HashMap<>();
        for (char c : s.toCharArray()) {
            freqMap.put(c, freqMap.getOrDefault(c, 0) + 1);
        }

        int deletions = 0;
        for (int freq : freqMap.values()) {
            if (freq < k) {
                deletions += freq;
            }
        }
        return deletions;
    }
}