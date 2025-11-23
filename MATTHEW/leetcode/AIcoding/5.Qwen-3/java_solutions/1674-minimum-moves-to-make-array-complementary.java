public class Solution {

import java.util.*;

public class Solution {
    public int minMoves(int[] nums, int limit) {
        int n = nums.length;
        int[] diff = new int[2 * limit + 2];

        for (int i = 0; i < n / 2; i++) {
            int a = nums[i];
            int b = nums[n - 1 - i];
            int minVal = Math.min(a, b);
            int maxVal = Math.max(a, b);
            int sum = a + b;

            diff[1] += 1;
            diff[sum] -= 1;
            diff[sum + 1] += 1;
            diff[limit + 1] -= 1;

            if (minVal > 1) {
                diff[1] += 1;
                diff[minVal] -= 1;
            }
            if (maxVal < limit) {
                diff[maxVal + 1] += 1;
                diff[limit + 1] -= 1;
            }
        }

        int res = 0;
        int current = 0;
        for (int i = 1; i <= limit; i++) {
            current += diff[i];
            res = Math.min(res, current);
        }

        return res;
    }
}
}