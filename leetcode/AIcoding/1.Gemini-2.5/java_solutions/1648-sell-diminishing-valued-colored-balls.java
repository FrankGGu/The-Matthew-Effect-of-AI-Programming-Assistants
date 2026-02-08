import java.util.TreeMap;
import java.util.Map;

class Solution {
    private static final int MOD = 1_000_000_007;

    // Helper function to calculate the sum of an arithmetic series (start + (start-1) + ... + end)
    // where start >= end.
    // The sum is (start + end) * (start - end + 1) / 2.
    // It's guaranteed that (start + end) * (start - end + 1) is always even,
    // so division by 2 is safe before applying modulo.
    private long sumArithmeticSeries(long start, long end) {
        long n = start - end + 1; // Number of terms in the series
        long sum = 0;

        // To prevent potential overflow before division by 2,
        // we check which term ((start + end) or n) is even and divide it first.
        if ((start + end) % 2 == 0) {
            long term1 = (start + end) / 2;
            long term2 = n;
            sum = (term1 % MOD * term2 % MOD) % MOD;
        } else { // n must be even
            long term1 = (start + end);
            long term2 = n / 2;
            sum = (term1 % MOD * term2 % MOD) % MOD;
        }
        return sum;
    }

    public int maxProfit(int[] inventory, int orders) {
        // TreeMap to store current ball counts (value) -> number of piles with that count.
        // Keys are sorted in ascending order, so lastKey() gives the maximum count.
        TreeMap<Integer, Integer> counts = new TreeMap<>();
        for (int val : inventory) {
            if (val > 0) { // Only consider piles with positive number of balls
                counts.put(val, counts.getOrDefault(val, 0) + 1);
            }
        }

        long totalProfit = 0;
        long remainingOrders = orders;

        // Continue as long as there are orders to fulfill and balls available
        while (remainingOrders > 0 && !counts.isEmpty()) {
            long maxVal = counts.lastKey(); // Current highest value of balls available
            long numPilesAtMaxVal = counts.get(counts.lastKey()); // Number of piles with 'maxVal' balls

            // Find the next highest value. If no lower key, it means all other piles are depleted,
            // so we consider the next highest value to be 0.
            long nextMaxVal = 0;
            if (counts.lowerKey(counts.lastKey()) != null) {
                nextMaxVal = counts.lowerKey(counts.lastKey());
            }

            // 'k' represents the number of "layers" of balls we can sell from 'maxVal'
            // down to 'nextMaxVal + 1' from each of the 'numPilesAtMaxVal' piles.
            long k = maxVal - nextMaxVal;

            // Calculate the total number of balls that would be sold if we process all 'k' layers
            // from all 'numPilesAtMaxVal' piles.
            long ballsToSellFromThesePiles = numPilesAtMaxVal * k;

            if (remainingOrders >= ballsToSellFromThesePiles) {
                // Case 1: We have enough or more orders to sell all 'k' layers from all relevant piles.
                // Calculate profit from selling balls from 'maxVal' down to 'nextMaxVal + 1' for each pile.
                long profitThisStep = numPilesAtMaxVal * sumArithmeticSeries(maxVal, nextMaxVal + 1);
                totalProfit = (totalProfit + profitThisStep) % MOD;
                remainingOrders -= ballsToSellFromThesePiles;

                // Update counts: remove the 'maxVal' entry.
                // All these piles now effectively have 'nextMaxVal' balls.
                // So, add 'numPilesAtMaxVal' to the count of piles at 'nextMaxVal'.
                // Only add if 'nextMaxVal' is positive, as 0-valued piles are considered depleted.
                counts.remove(counts.lastKey());
                if (nextMaxVal > 0) {
                    counts.put((int) nextMaxVal, (int) (counts.getOrDefault((int) nextMaxVal, 0) + numPilesAtMaxVal));
                }
            } else {
                // Case 2: We don't have enough orders to sell all 'k' layers from all piles.
                // We will sell as many full layers as possible, and then the remaining orders one by one.

                // Number of full layers we can sell from each of the 'numPilesAtMaxVal' piles.
                long fullLayers = remainingOrders / numPilesAtMaxVal;

                // Calculate profit from selling these 'fullLayers' from each pile.
                long profitFromFullLayers = numPilesAtMaxVal * sumArithmeticSeries(maxVal, maxVal - fullLayers + 1);
                totalProfit = (totalProfit + profitFromFullLayers) % MOD;

                // Calculate remaining orders after selling the full layers.
                long ordersAfterFullLayers = remainingOrders % numPilesAtMaxVal;

                // Sell the 'ordersAfterFullLayers' one by one, each at the value 'maxVal - fullLayers'.
                long remainingValueToSellAt = maxVal - fullLayers;
                long profitFromRemainingOrders = ordersAfterFullLayers * remainingValueToSellAt;
                totalProfit = (totalProfit + profitFromRemainingOrders) % MOD;

                remainingOrders = 0; // All orders are fulfilled
            }
        }

        return (int) totalProfit;
    }
}