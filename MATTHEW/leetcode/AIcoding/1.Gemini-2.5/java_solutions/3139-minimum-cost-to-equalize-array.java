import java.util.Arrays;
import java.util.Comparator;

class Solution {
    private long calculateCost(int target, int[] nums, int[] cost) {
        long currentCost = 0;
        for (int i = 0; i < nums.length; i++) {
            currentCost += (long) Math.abs(nums[i] - target) * cost[i];
        }
        return currentCost;
    }

    public long minCost(int[] nums, int[] cost) {
        int n = nums.length;
        int[][] pairs = new int[n][2];
        for (int i = 0; i < n; i++) {
            pairs[i][0] = nums[i];
            pairs[i][1] = cost[i];
        }

        Arrays.sort(pairs, Comparator.comparingInt(a -> a[0]));

        long totalWeight = 0;
        for (int i = 0; i < n; i++) {
            totalWeight += pairs[i][1];
        }

        long currentWeightSum = 0;
        int medianX = -1;

        for (int i = 0; i < n; i++) {
            currentWeightSum += pairs[i][1];
            if (currentWeightSum >= (totalWeight + 1) / 2) {
                medianX = pairs[i][0];
                break;
            }
        }

        return calculateCost(medianX, nums, cost);
    }
}