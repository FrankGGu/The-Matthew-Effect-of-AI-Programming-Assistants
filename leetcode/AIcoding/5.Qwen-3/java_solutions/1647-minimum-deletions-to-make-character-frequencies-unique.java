public class Solution {

import java.util.*;

public class Solution {
    public int minDeletions(String s) {
        int[] freq = new int[26];
        for (char c : s.toCharArray()) {
            freq[c - 'a']++;
        }

        Set<Integer> usedFreq = new HashSet<>();
        int deletions = 0;

        for (int i = 0; i < 26; i++) {
            while (freq[i] > 0 && usedFreq.contains(freq[i])) {
                freq[i]--;
                deletions++;
            }
            if (freq[i] > 0) {
                usedFreq.add(freq[i]);
            }
        }

        return deletions;
    }
}
}