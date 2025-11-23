public class Solution {

import java.util.*;

public class Solution {
    public int minCostToConvertToAllSameValue(int[] nums) {
        int n = nums.length;
        Arrays.sort(nums);
        int[] prefix = new int[n];
        prefix[0] = nums[0];
        for (int i = 1; i < n; i++) {
            prefix[i] = prefix[i - 1] + nums[i];
        }
        int minCost = Integer.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            int cost = 0;
            if (i > 0) {
                cost += nums[i] * i - prefix[i - 1];
            }
            if (i < n - 1) {
                cost += (prefix[n - 1] - prefix[i]) - nums[i] * (n - i - 1);
            }
            minCost = Math.min(minCost, cost);
        }
        return minCost;
    }
}
}