public class Solution {

import java.util.*;

public class Solution {
    public int minimumOperationsToMakeAllDivisibleByThree(int[] nums) {
        int count0 = 0, count1 = 0, count2 = 0;
        for (int num : nums) {
            int rem = num % 3;
            if (rem == 0) count0++;
            else if (rem == 1) count1++;
            else count2++;
        }

        if (count0 == nums.length) return 0;

        int minOps = Integer.MAX_VALUE;
        if (count1 >= 1 && count2 >= 1) {
            minOps = Math.min(minOps, 2);
        }
        if (count1 >= 3) {
            minOps = Math.min(minOps, 3);
        }
        if (count2 >= 3) {
            minOps = Math.min(minOps, 3);
        }
        if (count1 >= 2 && count2 >= 1) {
            minOps = Math.min(minOps, 3);
        }
        if (count2 >= 2 && count1 >= 1) {
            minOps = Math.min(minOps, 3);
        }
        if (count1 >= 1) {
            minOps = Math.min(minOps, 1);
        }
        if (count2 >= 1) {
            minOps = Math.min(minOps, 1);
        }

        return minOps;
    }
}
}