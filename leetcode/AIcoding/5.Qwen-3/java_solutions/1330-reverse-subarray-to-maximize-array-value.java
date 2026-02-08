public class Solution {

import java.util.*;

public class Solution {
    public int maxValueAfterReverse(int[] a) {
        int n = a.length;
        if (n == 1) return 0;

        int maxVal = 0;
        for (int i = 0; i < n - 1; i++) {
            maxVal += Math.abs(a[i] - a[i + 1]);
        }

        int maxDiff1 = 0;
        int maxDiff2 = 0;
        int minDiff1 = Integer.MAX_VALUE;
        int minDiff2 = Integer.MAX_VALUE;

        for (int i = 0; i < n - 1; i++) {
            int d1 = Math.abs(a[i] - a[i + 1]);
            int d2 = Math.abs(a[i + 1] - a[i]);

            if (i > 0) {
                int val1 = Math.abs(a[0] - a[i + 1]) + Math.abs(a[i] - a[n - 1]);
                int val2 = Math.abs(a[0] - a[i]) + Math.abs(a[i + 1] - a[n - 1]);
                maxVal = Math.max(maxVal, val1 - d1 - d2);
                maxVal = Math.max(maxVal, val2 - d1 - d2);
            }

            int diff1 = a[i] - a[i + 1];
            int diff2 = a[i + 1] - a[i];
            maxDiff1 = Math.max(maxDiff1, diff1);
            maxDiff2 = Math.max(maxDiff2, diff2);
            minDiff1 = Math.min(minDiff1, diff1);
            minDiff2 = Math.min(minDiff2, diff2);
        }

        int candidate1 = Math.max(0, maxDiff1 - minDiff1);
        int candidate2 = Math.max(0, maxDiff2 - minDiff2);
        maxVal = Math.max(maxVal, Math.max(candidate1, candidate2));

        return maxVal;
    }
}
}