import java.util.HashSet;
import java.util.Set;

class Solution {
    public int minDeletions(String s) {
        int[] freq = new int[26];
        for (char c : s.toCharArray()) {
            freq[c - 'a']++;
        }

        int operations = 0;
        Set<Integer> usedFrequencies = new HashSet<>();

        for (int count : freq) {
            while (count > 0 && usedFrequencies.contains(count)) {
                count--;
                operations++;
            }
            if (count > 0) {
                usedFrequencies.add(count);
            }
        }

        return operations;
    }
}