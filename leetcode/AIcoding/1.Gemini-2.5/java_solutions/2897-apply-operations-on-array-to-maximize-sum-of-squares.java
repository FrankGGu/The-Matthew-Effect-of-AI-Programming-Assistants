import java.util.Arrays;

class Solution {
    public int maximizeSquareSum(int[] nums, int k) {
        long MOD = 1_000_000_007;
        int n = nums.length;

        // Step 1: Count the frequency of each bit position being set across all numbers.
        // Assuming numbers are non-negative and fit in int (up to 30 bits for positive values).
        // Max value of int is 2^31 - 1, so bits 0 to 30 are relevant.
        int[] bitCounts = new int[31]; 
        for (int num : nums) {
            for (int j = 0; j < 31; j++) {
                if (((num >> j) & 1) == 1) {
                    bitCounts[j]++;
                }
            }
        }

        // Step 2: Distribute k operations greedily.
        // To maximize the sum of squares, we want to make the numbers as large as possible.
        // This means setting higher bits for as many numbers as possible.
        // Iterate from the most significant bit (30) down to the least significant bit (0).
        for (int j = 30; j >= 0; j--) {
            // Number of elements that currently do NOT have the j-th bit set.
            int neededToSetAll = n - bitCounts[j];

            if (k >= neededToSetAll) {
                // If we have enough operations to set this bit for all numbers that don't have it, do so.
                k -= neededToSetAll;
                bitCounts[j] = n; // Now all 'n' numbers effectively have this bit set.
            } else {
                // If we don't have enough operations to set this bit for all,
                // use the remaining 'k' operations to set this bit for 'k' additional numbers.
                bitCounts[j] += k;
                k = 0; // All operations are used.
                break; // No more operations left, so no higher bits can be set.
            }
            // Optimization: if k becomes 0 early, stop processing lower bits.
            if (k == 0) { 
                break;
            }
        }

        // Step 3: Reconstruct the numbers and calculate the sum of squares.
        // To maximize the sum of squares, given the final bit counts for each position,
        // we should arrange the bits such that the resulting numbers are as "concentrated" as possible.
        // This means the first 'bitCounts[j]' numbers (conceptually) will have bit 'j' set,
        // making them potentially larger than the other numbers.
        // Specifically, for each number index 'i' from 0 to n-1:
        // num[i] will have bit 'j' set if bitCounts[j] is greater than 'i'.
        // (i.e., if at least (i+1) numbers are supposed to have bit 'j' set, then num[i] gets it).

        long totalSumSquares = 0;

        // Use a temporary array to store the reconstructed numbers.
        // Use long to build numbers to avoid overflow during bitwise operations, as numbers can reach Integer.MAX_VALUE.
        long[] finalNums = new long[n]; 

        for (int i = 0; i < n; i++) {
            long currentNum = 0;
            for (int j = 0; j < 31; j++) {
                if (bitCounts[j] > i) { // If this bit is set for at least (i+1) numbers
                    currentNum |= (1L << j);
                }
            }
            finalNums[i] = currentNum;
        }

        // Calculate the sum of squares modulo MOD.
        for (long num : finalNums) {
            long square = (num % MOD * num % MOD) % MOD; // Calculate square modulo MOD
            totalSumSquares = (totalSumSquares + square) % MOD;
        }

        return (int) totalSumSquares;
    }
}