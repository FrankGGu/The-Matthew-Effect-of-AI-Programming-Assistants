import java.util.HashMap;
import java.util.Map;

class Solution {
    public long countInterestingSubarrays(int[] nums, int modulo, int k) {
        long interestingSubarraysCount = 0;
        int currentPrefixSumCount = 0; // This stores the count of elements satisfying num % modulo == k in the prefix
        Map<Integer, Integer> remainderFrequency = new HashMap<>();

        // Initialize the frequency map with the remainder of an empty prefix sum (0) having a count of 1.
        // This handles subarrays that start from index 0.
        remainderFrequency.put(0, 1); 

        for (int num : nums) {
            // If the current number satisfies the condition, increment the prefix sum count
            if (num % modulo == k) {
                currentPrefixSumCount++;
            }

            // Calculate the remainder of the current prefix sum count when divided by modulo.
            // This represents (P[i+1] % modulo) in prefix sum notation.
            int currentRemainder = currentPrefixSumCount % modulo;

            // We are looking for a previous prefix sum P[l] such that:
            // (P[i+1] - P[l]) % modulo == k
            // This can be rewritten as:
            // P[l] % modulo == (P[i+1] % modulo - k + modulo) % modulo
            // The '+ modulo' ensures the result is non-negative before taking % modulo again.
            int targetRemainder = (currentRemainder - k + modulo) % modulo;

            // Add the number of times this targetRemainder has been seen before to our total count.
            // Each occurrence of targetRemainder corresponds to an interesting subarray ending at the current index.
            interestingSubarraysCount += remainderFrequency.getOrDefault(targetRemainder, 0);

            // Increment the frequency of the currentRemainder in the map.
            remainderFrequency.put(currentRemainder, remainderFrequency.getOrDefault(currentRemainder, 0) + 1);
        }

        return interestingSubarraysCount;
    }
}