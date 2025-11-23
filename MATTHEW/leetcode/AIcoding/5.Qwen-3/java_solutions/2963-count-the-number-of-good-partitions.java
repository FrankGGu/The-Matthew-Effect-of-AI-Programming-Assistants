public class Solution {

import java.util.*;

public class Solution {
    public int countGoodPartitions(String s) {
        int n = s.length();
        int[] last = new int[26];
        for (int i = 0; i < n; i++) {
            last[s.charAt(i) - 'a'] = i;
        }

        int res = 0;
        int prev = -1;
        for (int i = 0; i < n; i++) {
            prev = Math.max(prev, last[s.charAt(i) - 'a']);
            if (i == prev) {
                res++;
            }
        }

        return res;
    }
}
}