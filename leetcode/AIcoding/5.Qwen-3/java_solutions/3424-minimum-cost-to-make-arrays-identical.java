public class Solution {

import java.util.*;

public class Solution {
    public int minCost(int[] nums, int[] cost, int x) {
        int n = nums.length;
        int[][] pairs = new int[n][2];
        for (int i = 0; i < n; i++) {
            pairs[i][0] = nums[i];
            pairs[i][1] = cost[i];
        }
        Arrays.sort(pairs, (a, b) -> a[0] - b[0]);

        long[] prefix = new long[n];
        long total = 0;
        for (int i = 0; i < n; i++) {
            total += (long) pairs[i][1];
            prefix[i] = total;
        }

        long res = Long.MAX_VALUE;
        long totalCost = 0;
        for (int i = 0; i < n; i++) {
            totalCost += (long) pairs[i][1] * (pairs[i][0] - pairs[0][0]);
        }
        res = Math.min(res, totalCost);

        for (int i = 1; i < n; i++) {
            long left = (long) pairs[i][1] * (pairs[i][0] - pairs[i - 1][0]);
            totalCost = totalCost - (prefix[i - 1] - (long) pairs[i][1]) * (pairs[i][0] - pairs[i - 1][0]) + left;
            res = Math.min(res, totalCost);
        }

        return (int) res;
    }
}
}