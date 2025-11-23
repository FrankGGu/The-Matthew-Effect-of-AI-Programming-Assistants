class Solution {
    public long minCost(int[] nums, int x) {
        int n = nums.length;
        long[] minCost = new long[n];
        for (int i = 0; i < n; i++) {
            minCost[i] = (long) i * x;
        }

        for (int i = 0; i < n; i++) {
            int current = nums[i];
            for (int k = 0; k < n; k++) {
                current = Math.min(current, nums[(i - k + n) % n]);
                minCost[k] += current;
            }
        }

        long result = Long.MAX_VALUE;
        for (long cost : minCost) {
            result = Math.min(result, cost);
        }
        return result;
    }
}