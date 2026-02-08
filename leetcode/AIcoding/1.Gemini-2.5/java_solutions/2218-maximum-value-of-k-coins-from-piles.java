import java.util.List;
import java.util.Arrays;

class Solution {
    public int maxValueOfCoins(List<List<Integer>> piles, int k) {
        // dp[j] will store the maximum value for j coins using piles processed so far.
        // Initialize with 0.
        // The size is k + 1 because we need to store values for 0 to k coins.
        int[] dp = new int[k + 1];

        // Iterate through each pile
        for (List<Integer> pile : piles) {
            // Calculate prefix sums for the current pile.
            // prefixSums[x] will store the sum of the first x coins from the pile.
            // prefixSums[0] = 0 (taking 0 coins gives 0 value)
            // prefixSums[1] = pile.get(0)
            // prefixSums[2] = pile.get(0) + pile.get(1)
            // ...
            int[] currentPilePrefixSums = new int[pile.size() + 1];
            for (int i = 0; i < pile.size(); i++) {
                currentPilePrefixSums[i + 1] = currentPilePrefixSums[i] + pile.get(i);
            }

            // Iterate j from k down to 0.
            // This ensures that when we calculate dp[j], dp[j - x] refers to the
            // state before considering the current pile, which is crucial for
            // a 0/1 knapsack-like update (each pile is processed once).
            for (int j = k; j >= 0; j--) {
                // Try taking x coins from the current pile.
                // x can range from 0 up to min(j, pile.size()).
                // The case x=0 means we don't take any coins from the current pile.
                // dp[j] already holds the best value without taking any coins from the current pile.
                // So, we only need to iterate x from 1.
                for (int x = 1; x <= Math.min(j, pile.size()); x++) {
                    // dp[j - x] is the maximum value for (j - x) coins from previous piles.
                    // currentPilePrefixSums[x] is the value obtained by taking x coins from the current pile.
                    dp[j] = Math.max(dp[j], dp[j - x] + currentPilePrefixSums[x]);
                }
            }
        }

        // The final answer is the maximum value for k coins using all piles.
        return dp[k];
    }
}