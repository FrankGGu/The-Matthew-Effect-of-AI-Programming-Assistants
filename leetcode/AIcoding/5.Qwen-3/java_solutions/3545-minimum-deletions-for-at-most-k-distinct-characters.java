public class Solution {

import java.util.*;

public class Solution {
    public int minDeletions(String s, int k) {
        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }

        Arrays.sort(count);
        int deletions = 0;

        for (int i = 24; i >= 0; i--) {
            if (count[i] == 0) continue;
            int target = Math.max(0, count[i + 1] - k);
            if (count[i] > target) {
                deletions += count[i] - target;
                count[i] = target;
            }
        }

        return deletions;
    }
}
}