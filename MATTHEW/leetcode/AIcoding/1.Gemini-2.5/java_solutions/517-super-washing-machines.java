class Solution {
    public int findMinMoves(int[] machines) {
        int n = machines.length;
        int totalDresses = 0;
        for (int dresses : machines) {
            totalDresses += dresses;
        }

        if (totalDresses % n != 0) {
            return -1;
        }

        int avgDresses = totalDresses / n;
        int maxMoves = 0;
        int balance = 0; // Represents the cumulative imbalance up to the current machine

        for (int dresses : machines) {
            int diff = dresses - avgDresses;
            balance += diff;

            // maxMoves is the maximum of two values:
            // 1. The maximum number of dresses a single machine needs to give away.
            //    This is `diff` if `diff > 0`.
            // 2. The maximum absolute cumulative imbalance that must pass through any point.
            //    This is `Math.abs(balance)`.

            // The moves required for a machine to shed its excess dresses
            // (if it has more than average)
            maxMoves = Math.max(maxMoves, diff); 

            // The moves required to balance the cumulative deficit/surplus
            // across a partition
            maxMoves = Math.max(maxMoves, Math.abs(balance));
        }

        return maxMoves;
    }
}