public class Solution {

import java.util.*;

public class Solution {
    public int minNumberOfSemesters(int n, int[][] relations) {
        int[] prereq = new int[n];
        for (int[] r : relations) {
            prereq[r[1]] |= 1 << r[0];
        }

        int full = (1 << n) - 1;
        int[] dp = new int[1 << n];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        for (int mask = 0; mask <= full; mask++) {
            if (dp[mask] == Integer.MAX_VALUE) continue;
            int next = 0;
            for (int i = 0; i < n; i++) {
                if ((mask & (1 << i)) == 0 && (prereq[i] & mask) == prereq[i]) {
                    next |= 1 << i;
                }
            }
            int courses = next;
            while (courses > 0) {
                int last = courses & -courses;
                int newMask = mask | last;
                dp[newMask] = Math.min(dp[newMask], dp[mask] + 1);
                courses ^= last;
            }
        }

        return dp[full];
    }
}
}