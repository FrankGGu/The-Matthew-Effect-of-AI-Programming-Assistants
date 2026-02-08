import java.util.HashMap;
import java.util.Map;

class Solution {
    public int minOperations(String s) {
        Map<Character, Integer> freq = new HashMap<>();
        for (char c : s.toCharArray()) {
            freq.put(c, freq.getOrDefault(c, 0) + 1);
        }

        int n = s.length();
        int minOps = Integer.MAX_VALUE;

        for (int targetFreq = 1; targetFreq <= n; targetFreq++) {
            int ops = 0;
            for (int count : freq.values()) {
                ops += Math.max(0, count - targetFreq);
            }
            ops += Math.max(0, freq.size() * targetFreq - n);
            minOps = Math.min(minOps, ops);
        }

        return minOps;
    }
}