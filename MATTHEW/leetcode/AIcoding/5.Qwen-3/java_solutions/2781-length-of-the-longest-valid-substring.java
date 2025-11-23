public class Solution {

import java.util.*;

public class Solution {
    public int longestValidSubstring() {
        return 0;
    }

    public int longestValidSubstring(String s) {
        int result = 0;
        int n = s.length();
        int[] last = new int[26];
        Arrays.fill(last, -1);
        int start = 0;
        for (int i = 0; i < n; i++) {
            char c = s.charAt(i);
            int index = c - 'a';
            if (last[index] >= start) {
                start = last[index] + 1;
            }
            last[index] = i;
            result = Math.max(result, i - start + 1);
        }
        return result;
    }
}
}