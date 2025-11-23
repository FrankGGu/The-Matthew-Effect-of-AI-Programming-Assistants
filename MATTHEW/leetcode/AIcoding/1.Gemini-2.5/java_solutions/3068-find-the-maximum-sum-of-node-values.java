class Solution {
    public long maximumValueSum(int[] nums, int k, int[][] edges) {
        long totalBaseSum = 0;
        for (int num : nums) {
            totalBaseSum += num;
        }

        long currentTotalSum = totalBaseSum;
        int countXorNodes = 0;
        long minPositiveGain = Long.MAX_VALUE;
        long maxNegativeGain = Long.MIN_VALUE;

        for (int num : nums) {
            long valOriginal = num;
            long valXor = num ^ k;
            long gain = valXor - valOriginal;

            if (gain > 0) {
                currentTotalSum += gain;
                countXorNodes++;
                minPositiveGain = Math.min(minPositiveGain, gain);
            } else { // gain <= 0
                maxNegativeGain = Math.max(maxNegativeGain, gain);
            }
        }

        if (countXorNodes % 2 == 0) {
            return currentTotalSum;
        } else {
            // countXorNodes is odd. We must change one choice to make it even.
            // Option 1: Revert a positive gain. This means we undo the XOR on one node that had a positive gain.
            //           We lose minPositiveGain. This is only possible if minPositiveGain was updated.
            long option1Sum = Long.MIN_VALUE;
            if (minPositiveGain != Long.MAX_VALUE) { 
                option1Sum = currentTotalSum - minPositiveGain;
            }

            // Option 2: Apply a negative/zero gain. This means we XOR one node that had a negative/zero gain.
            //           We add maxNegativeGain. This is only possible if maxNegativeGain was updated.
            long option2Sum = Long.MIN_VALUE;
            if (maxNegativeGain != Long.MIN_VALUE) { 
                option2Sum = currentTotalSum + maxNegativeGain;
            }

            return Math.max(option1Sum, option2Sum);
        }
    }
}