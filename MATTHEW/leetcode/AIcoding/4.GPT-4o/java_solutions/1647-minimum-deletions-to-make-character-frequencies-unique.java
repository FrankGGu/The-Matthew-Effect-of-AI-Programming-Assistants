import java.util.HashMap;
import java.util.HashSet;

class Solution {
    public int minDeletions(String s) {
        HashMap<Character, Integer> freqMap = new HashMap<>();
        for (char c : s.toCharArray()) {
            freqMap.put(c, freqMap.getOrDefault(c, 0) + 1);
        }

        HashSet<Integer> seen = new HashSet<>();
        int deletions = 0;

        for (int freq : freqMap.values()) {
            while (freq > 0 && seen.contains(freq)) {
                freq--;
                deletions++;
            }
            seen.add(freq);
        }

        return deletions;
    }
}