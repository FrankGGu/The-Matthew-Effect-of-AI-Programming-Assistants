import java.util.TreeSet;

class Solution {
    public int minPositiveSumSubarray(int[] nums) {
        long minPositiveSum = Long.MAX_VALUE;
        TreeSet<Long> prefixSums = new TreeSet<>();
        prefixSums.add(0L); // Add prefix sum before the first element (P[0])

        long currentPrefixSum = 0L;
        for (int num : nums) {
            currentPrefixSum += num;

            // For the current prefix sum (P[j+1]), we want to find a previous prefix sum (P[i])
            // such that P[j+1] - P[i] is minimized and positive.
            // To minimize P[j+1] - P[i] while keeping it positive, P[i] must be
            // the largest possible value that is strictly less than P[j+1].
            // TreeSet.lower(value) returns the greatest element in this set strictly less than the given value.
            Long prevSum = prefixSums.lower(currentPrefixSum);

            if (prevSum != null) {
                long diff = currentPrefixSum - prevSum;
                // Since prevSum is strictly less than currentPrefixSum, diff will always be positive.
                minPositiveSum = Math.min(minPositiveSum, diff);
            }

            // Add the current prefix sum to the set for future calculations
            prefixSums.add(currentPrefixSum);
        }

        // If minPositiveSum is still Long.MAX_VALUE, it means no positive sum subarray was found.
        return (minPositiveSum == Long.MAX_VALUE) ? -1 : (int) minPositiveSum;
    }
}