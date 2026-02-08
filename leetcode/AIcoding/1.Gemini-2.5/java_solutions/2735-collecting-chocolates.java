class Solution {
    public long minCost(int[] chocolates, int x) {
        int n = chocolates.length;
        long minOverallCost = Long.MAX_VALUE;

        // currentMinCostsForTypes[j] stores the minimum cost found so far for chocolate type 'j'.
        // This minimum is considered over all rotations from 0 up to the current 'k'.
        long[] currentMinCostsForTypes = new long[n];

        // Initialize currentMinCostsForTypes for k=0.
        // For 0 rotations, the cost of type 'j' is simply chocolates[j].
        for (int j = 0; j < n; j++) {
            currentMinCostsForTypes[j] = chocolates[j];
        }

        // Iterate through all possible number of rotations 'k' (from 0 to n-1).
        // 'k' represents the total number of rotations performed.
        for (int k = 0; k < n; k++) {
            // Calculate the cost for performing 'k' rotations.
            long rotationCost = (long)k * x;

            // Calculate the sum of collection costs for all chocolate types
            // based on the minimum costs found up to 'k' rotations.
            long chocolateCollectionSum = 0;
            for (int j = 0; j < n; j++) {
                chocolateCollectionSum += currentMinCostsForTypes[j];
            }

            // Update the overall minimum total cost.
            minOverallCost = Math.min(minOverallCost, rotationCost + chocolateCollectionSum);

            // Update currentMinCostsForTypes for the *next* iteration (k+1).
            // For each chocolate type 'j' (originally at index 'j'):
            // If we perform 'k+1' rotations, this type 'j' chocolate will be at index (j + k + 1) % n.
            // Its cost at that position is chocolates[(j + k + 1) % n].
            // We update currentMinCostsForTypes[j] to be the minimum of its current value
            // (which considers 0 to 'k' rotations) and this new potential cost (considering 'k+1' rotations).
            for (int j = 0; j < n; j++) {
                currentMinCostsForTypes[j] = Math.min(currentMinCostsForTypes[j], (long)chocolates[(j + k + 1) % n]);
            }
        }

        return minOverallCost;
    }
}