class Solution {
    private long calculateCost(int target, int[] nums, int[] cost) {
        long currentCost = 0;
        for (int i = 0; i < nums.length; i++) {
            currentCost += (long) Math.abs(nums[i] - target) * cost[i];
        }
        return currentCost;
    }

    public long minCost(int[] nums, int[] cost) {
        int minVal = nums[0];
        int maxVal = nums[0];
        for (int num : nums) {
            minVal = Math.min(minVal, num);
            maxVal = Math.max(maxVal, num);
        }

        long overallMinCost = Long.MAX_VALUE;

        int left = minVal;
        int right = maxVal;

        while (right - left >= 3) {
            int m1 = left + (right - left) / 3;
            int m2 = right - (right - left) / 3;

            long cost1 = calculateCost(m1, nums, cost);
            long cost2 = calculateCost(m2, nums, cost);

            if (cost1 < cost2) {
                right = m2;
            } else {
                left = m1;
            }
        }

        for (int i = left; i <= right; i++) {
            overallMinCost = Math.min(overallMinCost, calculateCost(i, nums, cost));
        }

        return overallMinCost;
    }
}