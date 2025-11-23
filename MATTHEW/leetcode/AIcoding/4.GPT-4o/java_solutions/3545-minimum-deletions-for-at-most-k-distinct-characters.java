import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int minDeletions(String s, int k) {
        Map<Character, Integer> freqMap = new HashMap<>();
        for (char c : s.toCharArray()) {
            freqMap.put(c, freqMap.getOrDefault(c, 0) + 1);
        }

        int[] freq = freqMap.values().stream().mapToInt(i -> i).toArray();
        Arrays.sort(freq);

        int deletions = 0;
        for (int i = 0; i < freq.length - k; i++) {
            deletions += freq[i];
        }

        return deletions;
    }
}