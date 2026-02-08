public class Solution {

import java.util.*;

public class Solution {
    public int minPositiveSumSubarray(int[] nums) {
        int minSum = Integer.MAX_VALUE;
        int currentSum = 0;

        for (int num : nums) {
            currentSum += num;
            if (currentSum > 0) {
                minSum = Math.min(minSum, currentSum);
            } else {
                currentSum = 0;
            }
        }

        return minSum;
    }
}
}