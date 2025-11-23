class Solution {
    public int minCostToEqualizeArray(int[] nums, int cost1, int cost2) {
        int MOD = 1_000_000_007;
        int n = nums.length;
        int max = 0;
        for (int num : nums) {
            max = Math.max(max, num);
        }
        long total = 0;
        for (int num : nums) {
            total += max - num;
        }
        if (cost1 * 2 <= cost2 || n <= 2) {
            return (int) ((total * cost1) % MOD);
        }
        long res = Long.MAX_VALUE;
        long maxOperations = 2 * total / n;
        for (long t = max; t <= max + maxOperations + 2; t++) {
            long sum = 0;
            long maxDiff = 0;
            for (int num : nums) {
                long diff = t - num;
                sum += diff;
                maxDiff = Math.max(maxDiff, diff);
            }
            long pairs = (sum - maxDiff);
            long currentCost = 0;
            if (pairs >= maxDiff) {
                currentCost = (sum / 2) * cost2 + (sum % 2) * cost1;
            } else {
                currentCost = pairs * cost2 + (sum - 2 * pairs) * cost1;
            }
            res = Math.min(res, currentCost);
        }
        return (int) (res % MOD);
    }
}