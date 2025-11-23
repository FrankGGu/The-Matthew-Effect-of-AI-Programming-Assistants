public class Solution {

import java.util.*;

public class Solution {
    public int longestAlternatingSubsequence(String s) {
        int n = s.length();
        int[] up = new int[n];
        int[] down = new int[n];

        Arrays.fill(up, 1);
        Arrays.fill(down, 1);

        for (int i = 1; i < n; i++) {
            for (int j = 0; j < i; j++) {
                if (s.charAt(j) < s.charAt(i)) {
                    up[i] = Math.max(up[i], down[j] + 1);
                } else if (s.charAt(j) > s.charAt(i)) {
                    down[i] = Math.max(down[i], up[j] + 1);
                }
            }
        }

        int result = 0;
        for (int i = 0; i < n; i++) {
            result = Math.max(result, Math.max(up[i], down[i]));
        }

        return result;
    }
}
}