public class Solution {

import java.util.*;

public class Solution {
    public int minDeletionsToKSpecial(String s, int k) {
        int[] freq = new int[26];
        for (char c : s.toCharArray()) {
            freq[c - 'a']++;
        }

        Arrays.sort(freq);
        int deletions = 0;
        for (int i = 24; i >= 0; i--) {
            if (freq[i] == 0) continue;
            int target = Math.max(0, freq[i + 1] - 1);
            if (freq[i] > target) {
                deletions += freq[i] - target;
                freq[i] = target;
            }
        }

        int count = 0;
        for (int f : freq) {
            if (f > 0) count++;
        }

        return count >= k ? deletions : -1;
    }
}
}