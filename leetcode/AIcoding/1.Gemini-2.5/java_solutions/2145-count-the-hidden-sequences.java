class Solution {
    public int numberOfHiddenSequences(int[] differences, int lower, int upper) {
        long currentPrefixSum = 0;
        long minPrefixSum = 0;
        long maxPrefixSum = 0;

        for (int diff : differences) {
            currentPrefixSum += diff;
            minPrefixSum = Math.min(minPrefixSum, currentPrefixSum);
            maxPrefixSum = Math.max(maxPrefixSum, currentPrefixSum);
        }

        long lowerBoundA0 = lower - minPrefixSum;
        long upperBoundA0 = upper - maxPrefixSum;

        if (lowerBoundA0 > upperBoundA0) {
            return 0;
        } else {
            return (int)(upperBoundA0 - lowerBoundA0 + 1);
        }
    }
}