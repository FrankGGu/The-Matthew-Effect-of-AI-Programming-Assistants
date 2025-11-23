import java.util.Arrays;

class Solution {
    public long putMarbles(int[] weights, int k) {
        int n = weights.length;

        long[] adjacentPairSums = new long[n - 1];
        for (int i = 0; i < n - 1; i++) {
            adjacentPairSums[i] = (long) weights[i] + weights[i + 1];
        }

        Arrays.sort(adjacentPairSums);

        long minSumOfSplits = 0;
        for (int i = 0; i < k - 1; i++) {
            minSumOfSplits += adjacentPairSums[i];
        }

        long maxSumOfSplits = 0;
        for (int i = 0; i < k - 1; i++) {
            maxSumOfSplits += adjacentPairSums[n - 2 - i];
        }

        return maxSumOfSplits - minSumOfSplits;
    }
}