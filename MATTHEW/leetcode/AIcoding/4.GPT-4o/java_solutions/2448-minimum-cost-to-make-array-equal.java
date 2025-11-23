class Solution {
    public long minCost(int[] A, int x) {
        int n = A.length;
        long minCost = Long.MAX_VALUE;
        int maxA = 0;

        for (int num : A) {
            maxA = Math.max(maxA, num);
        }

        for (int target = 1; target <= maxA; target++) {
            long cost = 0;
            for (int num : A) {
                cost += Math.abs(num - target);
            }
            minCost = Math.min(minCost, cost + (long) target * x);
        }

        return minCost;
    }
}