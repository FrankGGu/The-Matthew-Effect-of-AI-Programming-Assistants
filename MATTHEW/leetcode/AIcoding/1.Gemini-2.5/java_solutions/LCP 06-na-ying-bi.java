class Solution {
    public long minOperations(int[] coins) {
        long sum = 0;
        long maxVal = 0;

        for (int coin : coins) {
            sum += coin;
            if (coin > maxVal) {
                maxVal = coin;
            }
        }

        // The minimum number of operations is determined by two factors:
        // 1. The largest pile: We must perform at least 'maxVal' operations because each operation
        //    can take at most one coin from the largest pile.
        // 2. The total number of coins: Each operation takes at most two coins (one from each of two piles).
        //    Therefore, we need at least 'ceil(sum / 2)' operations.
        //    In integer arithmetic, ceil(sum / 2) can be calculated as (sum + 1) / 2.
        // The actual minimum operations will be the maximum of these two lower bounds.
        return Math.max(maxVal, (sum + 1) / 2);
    }
}