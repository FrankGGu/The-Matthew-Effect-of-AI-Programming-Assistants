import java.util.Arrays;

class Solution {
    public long[] solve(int[] nums, int[] queries) {
        // Step 1: Find the maximum value in nums to determine array sizes
        int maxVal = 0;
        for (int num : nums) {
            if (num > maxVal) {
                maxVal = num;
            }
        }

        // Step 2: Count frequencies of each number in nums
        // freq[v] stores the number of occurrences of v in nums
        int[] freq = new int[maxVal + 1];
        for (int num : nums) {
            freq[num]++;
        }

        // Step 3: Calculate numMultiples[g] = count of numbers in nums that are multiples of g
        // This is done by iterating through all possible GCDs 'g'
        // and for each 'g', summing up frequencies of its multiples.
        long[] numMultiples = new long[maxVal + 1];
        for (int g = 1; g <= maxVal; g++) {
            for (int multiple = g; multiple <= maxVal; multiple += g) {
                numMultiples[g] += freq[multiple];
            }
        }

        // Step 4: Calculate countPairsMultipleOfG[g] = number of pairs (i, j) with i < j
        // such that both nums[i] and nums[j] are multiples of g.
        // If there are 'C' numbers in nums that are multiples of 'g',
        // then there are C * (C - 1) / 2 such pairs.
        long[] countPairsMultipleOfG = new long[maxVal + 1];
        for (int g = 1; g <= maxVal; g++) {
            countPairsMultipleOfG[g] = numMultiples[g] * (numMultiples[g] - 1) / 2;
        }

        // Step 5: Calculate ans[g] = number of pairs (i, j) with i < j such that gcd(nums[i], nums[j]) = g
        // This is done using the inclusion-exclusion principle, iterating 'g' downwards.
        // countPairsMultipleOfG[g] includes pairs whose GCD is g, 2g, 3g, etc.
        // By subtracting counts for multiples of g (2g, 3g, ...), we isolate pairs with exact GCD = g.
        long[] ans = new long[maxVal + 1];
        for (int g = maxVal; g >= 1; g--) {
            ans[g] = countPairsMultipleOfG[g]; // Initialize with pairs whose GCD is a multiple of g
            // Subtract counts for pairs whose GCD is a multiple of g but greater than g (e.g., 2g, 3g, ...)
            for (int multiple = 2 * g; multiple <= maxVal; multiple += g) {
                ans[g] -= ans[multiple];
            }
        }

        // Step 6: Process queries
        // For each query K, the answer is directly available in ans[K]
        long[] result = new long[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int k = queries[i];
            if (k <= maxVal) {
                result[i] = ans[k];
            } else {
                // If K is greater than the maximum value in nums, no GCD can be K.
                result[i] = 0;
            }
        }

        return result;
    }
}