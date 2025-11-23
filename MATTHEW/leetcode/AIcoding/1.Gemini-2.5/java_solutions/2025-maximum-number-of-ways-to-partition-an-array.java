import java.util.HashMap;
import java.util.Map;

class Solution {
    public int waysToPartition(int[] nums, int k) {
        int N = nums.length;
        long[] prefixSums = new long[N + 1];
        for (int j = 0; j < N; j++) {
            prefixSums[j + 1] = prefixSums[j] + nums[j];
        }
        long totalSum = prefixSums[N];

        int maxCount = 0;

        // Case 1: No change to any element.
        // Iterate through all possible partition points p (from 1 to N-1).
        // A partition at p means nums[0...p-1] is the left part, nums[p...N-1] is the right part.
        // We need sum(left) == sum(right), which means 2 * sum(left) == totalSum.
        if (totalSum % 2 == 0) {
            long target = totalSum / 2;
            int currentCount = 0;
            for (int p = 1; p < N; p++) {
                if (prefixSums[p] == target) {
                    currentCount++;
                }
            }
            maxCount = currentCount;
        }

        // Case 2: Change one element nums[i] to k.
        // We use two frequency maps to efficiently count partitions.
        // leftPrefixSumFreq: Stores frequencies of prefixSums[p] for partition points p where 1 <= p <= i.
        // rightPrefixSumFreq: Stores frequencies of prefixSums[p] for partition points p where i < p <= N-1.
        Map<Long, Integer> leftPrefixSumFreq = new HashMap<>();
        Map<Long, Integer> rightPrefixSumFreq = new HashMap<>();

        // Initialize rightPrefixSumFreq with all prefix sums for p from 1 to N-1.
        // This represents the state before we start iterating i (i.e., when i=0, all partitions are 'to the right' of i).
        for (int p = 1; p < N; p++) {
            rightPrefixSumFreq.put(prefixSums[p], rightPrefixSumFreq.getOrDefault(prefixSums[p], 0) + 1);
        }

        for (int i = 0; i < N; i++) { // nums[i] is the element being changed to k
            // At the start of iteration i:
            // leftPrefixSumFreq contains prefixSums[p] for 1 <= p <= i.
            // rightPrefixSumFreq contains prefixSums[p] for i+1 <= p <= N-1.

            // If i > 0, the prefix sum prefixSums[i] (sum of nums[0]...nums[i-1])
            // was considered "to the right" of the previous changed element (i-1).
            // Now, for the current changed element nums[i], prefixSums[i] is "to the left" of i.
            // So, move prefixSums[i] from rightPrefixSumFreq to leftPrefixSumFreq.
            if (i > 0) {
                // Remove prefixSums[i] from rightPrefixSumFreq
                rightPrefixSumFreq.put(prefixSums[i], rightPrefixSumFreq.get(prefixSums[i]) - 1);
                if (rightPrefixSumFreq.get(prefixSums[i]) == 0) {
                    rightPrefixSumFreq.remove(prefixSums[i]);
                }

                // Add prefixSums[i] to leftPrefixSumFreq
                leftPrefixSumFreq.put(prefixSums[i], leftPrefixSumFreq.getOrDefault(prefixSums[i], 0) + 1);
            }

            long diff = (long) k - nums[i];
            long newTotalSum = totalSum + diff;

            // If the new total sum is odd, no valid partition is possible.
            if (newTotalSum % 2 != 0) {
                continue;
            }

            long target = newTotalSum / 2;
            int currentWays = 0;

            // Count partitions p where 1 <= p <= i (i.e., partition point is to the left of or at the changed element).
            // For these partitions, prefixSums[p] is unchanged. We need prefixSums[p] == target.
            currentWays += leftPrefixSumFreq.getOrDefault(target, 0);

            // Count partitions p where i < p <= N-1 (i.e., partition point is to the right of the changed element).
            // For these partitions, prefixSums[p] (original sum) includes nums[i].
            // The new prefix sum will be prefixSums[p] + diff.
            // We need prefixSums[p] + diff == target, which means prefixSums[p] == target - diff.
            currentWays += rightPrefixSumFreq.getOrDefault(target - diff, 0);

            maxCount = Math.max(maxCount, currentWays);
        }

        return maxCount;
    }
}