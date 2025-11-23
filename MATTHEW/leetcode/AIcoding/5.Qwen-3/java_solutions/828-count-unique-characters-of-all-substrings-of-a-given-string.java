public class Solution {

import java.util.*;

public class Solution {
    public int uniqueLetterPercent(String s) {
        int n = s.length();
        int[] left = new int[n];
        int[] right = new int[n];
        Arrays.fill(left, -1);
        Arrays.fill(right, n);

        Map<Character, Integer> last = new HashMap<>();
        for (int i = 0; i < n; i++) {
            char c = s.charAt(i);
            if (last.containsKey(c)) {
                left[i] = last.get(c);
            }
            last.put(c, i);
        }

        last.clear();
        for (int i = n - 1; i >= 0; i--) {
            char c = s.charAt(i);
            if (last.containsKey(c)) {
                right[i] = last.get(c);
            }
            last.put(c, i);
        }

        int res = 0;
        for (int i = 0; i < n; i++) {
            res += (i - left[i]) * (right[i] - i);
        }

        return res;
    }
}
}