import java.util.Arrays;

class Solution {
    public long minimalKSum(int[] nums, int k) {
        Arrays.sort(nums);

        long currentSum = 0;
        long kRemaining = k;
        long expected = 1; // The next smallest positive integer we are looking for

        for (int num : nums) {
            if (kRemaining == 0) {
                break; 
            }

            // If num is greater than expected, it means there are missing numbers
            // between expected and num-1 that we can append.
            if (num > expected) {
                long countToAppend = Math.min(kRemaining, num - expected);

                // Sum of an arithmetic series: count * (first_term + last_term) / 2
                // first_term = expected
                // last_term = expected + countToAppend - 1
                currentSum += countToAppend * (expected + (expected + countToAppend - 1)) / 2;
                kRemaining -= countToAppend;
            }

            // Update expected to be num + 1, as num is present in the array.
            // Use Math.max to ensure expected always moves forward, even if num was smaller than current expected
            // (e.g., due to previous appends, expected already jumped ahead).
            // This also handles cases where num == expected, correctly moving expected past num.
            expected = Math.max(expected, (long)num + 1); 
        }

        // If kRemaining is still greater than 0 after iterating through nums,
        // we need to append the next kRemaining integers starting from 'expected'.
        if (kRemaining > 0) {
            long firstTerm = expected;
            long lastTerm = expected + kRemaining - 1;
            currentSum += kRemaining * (firstTerm + lastTerm) / 2;
        }

        return currentSum;
    }
}