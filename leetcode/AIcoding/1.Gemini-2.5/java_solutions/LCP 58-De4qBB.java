class Solution {

    public long getMinimumOperations(int[] blocks) {
        if (blocks == null || blocks.length == 0) {
            return 0;
        }

        // Step 1: Calculate the GCD of all block heights.
        // This will be the target height T.
        long commonDivisor = blocks[0];
        for (int i = 1; i < blocks.length; i++) {
            commonDivisor = gcd(commonDivisor, blocks[i]);
        }

        // Step 2: Calculate the total minimum cost.
        long totalCost = 0;
        for (int blockHeight : blocks) {
            long k = blockHeight / commonDivisor; // Number of target blocks (height commonDivisor) to get from current blockHeight

            // If k=1, the block already has the target height, no splits needed, cost is 0.
            // If k > 1, we need k-1 splits.
            // The costs of these splits are k*T, (k-1)*T, ..., 2*T.
            // The sum of an arithmetic series 2 + ... + k is (k*(k+1)/2) - 1.
            if (k > 1) {
                // The term k * (k + 1) / 2 can be up to ~0.5 * 10^18 (if k is 10^9), which fits in long.
                // The product with commonDivisor (max 10^9) could exceed long if k is also large,
                // but if commonDivisor is large, k will be small.
                // Max cost for a single block is when commonDivisor=1 and blockHeight=10^9,
                // which is 1 * (10^9 * (10^9+1)/2 - 1) ~ 0.5 * 10^18, fitting in long.
                long costForBlock = commonDivisor * (k * (k + 1) / 2 - 1);
                totalCost += costForBlock;
            }
        }

        return totalCost;
    }

    private long gcd(long a, long b) {
        while (b != 0) {
            long temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}