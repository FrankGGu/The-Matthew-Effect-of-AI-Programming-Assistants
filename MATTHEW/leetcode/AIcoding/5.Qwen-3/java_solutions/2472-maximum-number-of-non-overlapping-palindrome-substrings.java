public class Solution {

import java.util.*;

public class Solution {
    public int maxNumOfSubstrings(String s) {
        int n = s.length();
        int[] left = new int[n];
        int[] right = new int[n];

        for (int i = 0; i < n; i++) {
            int l = i, r = i;
            while (l >= 0 && r < n && s.charAt(l) == s.charAt(r)) {
                left[r] = l;
                right[l] = r;
                l--;
                r++;
            }
        }

        for (int i = 0; i < n; i++) {
            int l = i, r = i;
            while (l >= 0 && r < n && s.charAt(l) == s.charAt(r)) {
                left[r] = l;
                right[l] = r;
                l--;
                r++;
            }
        }

        List<int[]> intervals = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            if (left[i] == 0 && right[i] == n - 1) {
                intervals.add(new int[]{0, n - 1});
            } else {
                intervals.add(new int[]{left[i], right[i]});
            }
        }

        Collections.sort(intervals, (a, b) -> a[1] - b[1]);

        int count = 0;
        int lastEnd = -1;

        for (int[] interval : intervals) {
            if (interval[0] > lastEnd) {
                count++;
                lastEnd = interval[1];
            }
        }

        return count;
    }
}
}