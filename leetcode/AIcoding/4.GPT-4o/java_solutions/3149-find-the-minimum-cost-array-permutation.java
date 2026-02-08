import java.util.Arrays;

public class Solution {
    public int findMinCost(int[] nums, int[][] cost) {
        int n = nums.length;
        int minCost = Integer.MAX_VALUE;

        for (int x = 1; x <= 100; x++) {
            int currentCost = 0;
            for (int i = 0; i < n; i++) {
                currentCost += cost[i][Math.abs(nums[i] - x)];
            }
            minCost = Math.min(minCost, currentCost);
        }
        return minCost;
    }
}