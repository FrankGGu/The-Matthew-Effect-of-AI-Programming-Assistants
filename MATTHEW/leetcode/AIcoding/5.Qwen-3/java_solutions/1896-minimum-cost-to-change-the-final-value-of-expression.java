public class Solution {

import java.util.*;

public class Solution {
    public int minCostToEqual(int a, int b, int c, int d) {
        int[] nums = {a, b, c};
        int target = d;
        int minCost = Integer.MAX_VALUE;

        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                if (i == j) continue;
                int val1 = nums[i];
                int val2 = nums[j];
                int cost = 0;

                if (val1 != target) {
                    cost += Math.abs(val1 - target);
                }
                if (val2 != target) {
                    cost += Math.abs(val2 - target);
                }

                minCost = Math.min(minCost, cost);
            }
        }

        return minCost;
    }
}
}