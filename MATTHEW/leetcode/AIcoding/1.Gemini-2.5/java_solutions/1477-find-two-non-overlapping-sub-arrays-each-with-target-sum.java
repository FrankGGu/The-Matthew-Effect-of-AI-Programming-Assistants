import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public int minSumOfLengths(int[] arr, int target) {
        int n = arr.length;
        // minLen[i] stores the minimum length of a subarray with sum 'target'
        // that ENDS AT OR BEFORE index i.
        int[] minLen = new int[n];
        Arrays.fill(minLen, Integer.MAX_VALUE);

        Map<Integer, Integer> prefixSumMap = new HashMap<>(); // Stores (sum -> index)
        prefixSumMap.put(0, -1); // Base case for subarrays starting from index 0

        int currentSum = 0;
        int minTotalLength = Integer.MAX_VALUE;

        for (int i = 0; i < n; i++) {
            currentSum += arr[i];

            // Propagate the minimum length from the previous index
            if (i > 0) {
                minLen[i] = minLen[i - 1];
            }

            // Check if there's a subarray ending at 'i' with sum 'target'
            if (prefixSumMap.containsKey(currentSum - target)) {
                int prevIndex = prefixSumMap.get(currentSum - target); // This is the index *before* the start of the current subarray
                int currentSubarrayLength = i - prevIndex; // Length of the subarray [prevIndex + 1, i]

                // If we found a first subarray (ending at or before 'prevIndex')
                // and its length is valid (not MAX_VALUE),
                // then we can combine it with the current subarray [prevIndex + 1, i].
                // The two subarrays will be non-overlapping because the first one ends at 'prevIndex'
                // and the second one starts at 'prevIndex + 1'.
                if (prevIndex != -1 && minLen[prevIndex] != Integer.MAX_VALUE) {
                    minTotalLength = Math.min(minTotalLength, minLen[prevIndex] + currentSubarrayLength);
                }

                // Update minLen[i] with the current subarray length if it's shorter
                minLen[i] = Math.min(minLen[i], currentSubarrayLength);
            }

            prefixSumMap.put(currentSum, i);
        }

        return minTotalLength == Integer.MAX_VALUE ? -1 : minTotalLength;
    }
}