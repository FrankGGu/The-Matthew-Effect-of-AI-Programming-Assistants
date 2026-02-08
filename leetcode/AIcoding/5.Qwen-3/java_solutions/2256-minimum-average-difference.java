public class Solution {

import java.util.*;

public class Solution {
    public int minimumAverageDifference(int[] nums) {
        int n = nums.length;
        long totalSum = 0;
        for (int num : nums) {
            totalSum += num;
        }

        long leftSum = 0;
        int minIndex = 0;
        double minAvg = Double.MAX_VALUE;

        for (int i = 0; i < n; i++) {
            leftSum += nums[i];
            long rightSum = totalSum - leftSum;

            double leftAvg = (double) leftSum / (i + 1);
            double rightAvg = (i == n - 1) ? 0 : (double) rightSum / (n - i - 1);

            double diff = Math.abs(leftAvg - rightAvg);
            if (diff < minAvg || (diff == minAvg && i < minIndex)) {
                minAvg = diff;
                minIndex = i;
            }
        }

        return minIndex;
    }
}
}