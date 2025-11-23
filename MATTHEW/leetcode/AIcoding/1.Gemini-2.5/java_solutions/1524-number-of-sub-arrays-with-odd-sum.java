class Solution {
    public int numOfSubarrays(int[] arr) {
        final int MOD = 1_000_000_007;
        int oddPrefixSums = 0;
        int evenPrefixSums = 1; // Represents the count of prefix sums that are even. S_0 = 0 is an even prefix sum.
        int currentPrefixSum = 0; 
        long totalOddSubarrays = 0;

        for (int num : arr) {
            currentPrefixSum += num;
            if (currentPrefixSum % 2 == 1) { // If the current prefix sum is odd
                // To get an odd subarray sum (current_prefix_sum - previous_prefix_sum),
                // previous_prefix_sum must be even.
                totalOddSubarrays = (totalOddSubarrays + evenPrefixSums) % MOD;
                oddPrefixSums++;
            } else { // If the current prefix sum is even
                // To get an odd subarray sum (current_prefix_sum - previous_prefix_sum),
                // previous_prefix_sum must be odd.
                totalOddSubarrays = (totalOddSubarrays + oddPrefixSums) % MOD;
                evenPrefixSums++;
            }
        }

        return (int) totalOddSubarrays;
    }
}