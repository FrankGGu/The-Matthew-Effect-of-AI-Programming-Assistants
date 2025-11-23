import java.util.HashMap;
import java.util.Map;

class Solution {
    public long maximumGoodSubarraySum(int[] nums, int k) {
        long maxSum = Long.MIN_VALUE;
        long currentPrefixSum = 0;
        Map<Integer, Long> minPrefixSumMap = new HashMap<>();

        for (int j = 0; j < nums.length; j++) {
            int currentNum = nums[j];

            // Before updating currentPrefixSum to include nums[j],
            // currentPrefixSum holds the sum of elements from nums[0] to nums[j-1].
            // This is effectively the prefix sum *before* nums[j].
            // We store this value in the map for currentNum, as currentNum could be nums[i]
            // for a future subarray ending at some j' > j.
            minPrefixSumMap.put(currentNum, Math.min(minPrefixSumMap.getOrDefault(currentNum, Long.MAX_VALUE), currentPrefixSum));

            // Now, update currentPrefixSum to include nums[j].
            // This new currentPrefixSum represents sum(nums[0]...nums[j]).
            currentPrefixSum += currentNum;

            // Check for potential starting elements (nums[i]) that satisfy the condition with nums[j].
            // A good subarray nums[i...j] must have abs(nums[i] - nums[j]) == k.
            // This means nums[i] could be nums[j] - k or nums[j] + k.
            // The sum of nums[i...j] is (sum of nums[0]...nums[j]) - (sum of nums[0]...nums[i-1]).
            // In our terms: (currentPrefixSum after adding nums[j]) - (minPrefixSumMap.get(nums[i])).

            // Case 1: nums[i] = nums[j] - k
            long targetVal1 = (long) currentNum - k;
            if (minPrefixSumMap.containsKey((int) targetVal1)) {
                long minPrevSum1 = minPrefixSumMap.get((int) targetVal1);
                maxSum = Math.max(maxSum, currentPrefixSum - minPrevSum1);
            }

            // Case 2: nums[i] = nums[j] + k
            long targetVal2 = (long) currentNum + k;
            if (minPrefixSumMap.containsKey((int) targetVal2)) {
                long minPrevSum2 = minPrefixSumMap.get((int) targetVal2);
                maxSum = Math.max(maxSum, currentPrefixSum - minPrevSum2);
            }
        }

        // If maxSum is still Long.MIN_VALUE, it means no good subarray was found.
        // The problem asks to return 0 in that case.
        return maxSum == Long.MIN_VALUE ? 0 : maxSum;
    }
}