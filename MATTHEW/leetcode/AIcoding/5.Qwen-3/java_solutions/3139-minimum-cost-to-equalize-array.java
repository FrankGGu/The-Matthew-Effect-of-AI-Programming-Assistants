public class Solution {

import java.util.*;

public class Solution {
    public int minCostToEqualizeArray(int[] nums, int x) {
        int n = nums.length;
        int[] cost = new int[n];

        for (int i = 0; i < n; i++) {
            cost[i] = nums[i];
        }

        Arrays.sort(cost);

        int totalCost = 0;
        for (int i = 0; i < n; i++) {
            totalCost += Math.abs(nums[i] - cost[i]);
        }

        return totalCost;
    }
}
}