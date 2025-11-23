import java.util.List;
import java.util.Arrays;

class Solution {
    public int minOperations(List<Integer> nums, int target) {
        long totalSum = 0;
        // counts[i] stores the number of 2^i available
        // Max target is 10^9, which is less than 2^30.
        // So, we need to consider powers up to 2^30.
        // An array of size 32 will cover indices 0 to 31.
        // Index 31 is for potential carry-over from 2^30.
        long[] counts = new long[32]; 

        for (int x : nums) {
            totalSum += x;
            // Integer.numberOfTrailingZeros(x) gives the exponent k for 2^k
            int power = Integer.numberOfTrailingZeros(x);
            counts[power]++;
        }

        // If the total sum of available numbers is less than target, it's impossible.
        if (totalSum < target) {
            return -1;
        }

        int operations = 0;

        // Iterate through powers of 2 from 2^0 up to 2^30 (or higher if target could be larger)
        // For int target, 2^30 is sufficient as max bit.
        for (int i = 0; i <= 30; i++) { 
            // If the i-th bit of target is set, we need a 2^i
            if (((target >> i) & 1) == 1) {
                if (counts[i] > 0) {
                    counts[i]--; // Use an available 2^i
                } else {
                    // We need a 2^i but don't have one. Find a larger power of 2 to split.
                    int j = i + 1;
                    // Search for the smallest 2^j (where j > i) that we have available.
                    while (j <= 31 && counts[j] == 0) { 
                        j++;
                    }

                    // If j exceeds the maximum possible power (index 31 in this case),
                    // it means we couldn't find any larger power to split.
                    // This scenario should not be reachable if totalSum >= target,
                    // as it implies target cannot be formed.
                    if (j > 31) {
                        // This line should theoretically not be hit given totalSum >= target.
                        // However, it's a safeguard for completeness.
                        return -1; 
                    }

                    // The cost to split one 2^j into one 2^i is (j - i) operations.
                    operations += (j - i); 
                    counts[j]--; // One 2^j is consumed.

                    // When a 2^j is split to obtain a 2^i, it effectively produces
                    // one 2^i (which we use for the target bit) and one 2^k for each
                    // intermediate power k from i+1 to j-1. These intermediate 2^k's become available.
                    for (int k = j - 1; k > i; k--) {
                        counts[k]++; // Make the intermediate powers available.
                    }
                    // The 2^i obtained is immediately used for the target bit, so its net change to counts[i] is 0.
                }
            }

            // After processing the i-th bit of target, any remaining 2^i's can be
            // combined into 2^(i+1)s and carried over to the next level.
            // This also consolidates any excess 2^i's that might have resulted from splits.
            if (i + 1 <= 31) { // Ensure we don't go out of bounds for the counts array.
                counts[i+1] += counts[i] / 2;
            }
        }

        return operations;
    }
}