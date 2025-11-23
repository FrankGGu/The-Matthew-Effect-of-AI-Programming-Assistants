class Solution {
    public boolean primeSubtractionOperation(int[] nums) {
        // Iterate through the array starting from the second element.
        // For each nums[i], we need to ensure nums[i] > nums[i-1].
        // To maximize the chances for subsequent elements, we should make nums[i] as small as possible,
        // which is nums[i-1] + 1.

        for (int i = 1; i < nums.length; i++) {
            int previous_val = nums[i-1];
            int current_val = nums[i];

            // Case 1: current_val is less than or equal to previous_val.
            // We must perform an operation to make current_val > previous_val.
            // We need to subtract a prime 'p' such that current_val - p > previous_val.
            // This implies p < current_val - previous_val.
            // Since current_val <= previous_val, the difference (current_val - previous_val) is 0 or negative.
            // There is no prime 'p' (p >= 2) that satisfies p < 0 or p < 1.
            // Thus, it's impossible to make nums[i] strictly greater than nums[i-1] in this scenario.
            if (current_val <= previous_val) {
                return false;
            }

            // Case 2: current_val is already strictly greater than previous_val.
            // We want to reduce current_val to its smallest possible value, which is previous_val + 1.
            // Let target_val = previous_val + 1.
            // The amount we need to subtract from current_val to reach target_val is 'diff'.
            int diff = current_val - (previous_val + 1);

            if (diff == 0) {
                // current_val is already previous_val + 1. No operation is needed.
                // nums[i] remains as current_val.
                continue;
            } else if (diff == 1) {
                // current_val is previous_val + 2.
                // We need to subtract 1 to make it previous_val + 1.
                // However, 1 is not a prime number.
                // If we subtract any prime p (p >= 2), the new value (current_val - p) would be
                // (previous_val + 2) - p. Since p >= 2, this would be <= previous_val.
                // This violates the condition (nums[i] - p > previous_val).
                // Therefore, it's impossible to make nums[i] equal to previous_val + 1 in this specific case.
                return false;
            } else { // diff >= 2
                // current_val is previous_val + 1 + diff, where diff >= 2.
                // We need to reduce current_val by 'diff'.
                // The problem states "You can perform this operation any number of times."
                // This means we can subtract multiple primes sequentially (e.g., subtract p1, then p2 from the new value).
                // Any integer K >= 2 can be expressed as a sum of primes (e.g., K=2+2+...+2 for even K, or K=3+2+2+...+2 for odd K >= 3).
                // We need to ensure that at each step, the value remains strictly greater than previous_val.
                // Let 'X' be the current value of nums[i] during the sequence of subtractions.
                // We subtract a prime 'p' such that X - p > previous_val, which means p <= X - (previous_val + 1).
                // The smallest value X - (previous_val + 1) can take is 2 (when X = previous_val + 3).
                // Since we use primes 2 or 3 for subtraction, and 2 <= 2 and 3 <= (any value >= 3),
                // we can always find a prime 'p' to subtract without violating the condition.
                // Thus, we can always reduce nums[i] to previous_val + 1.
                nums[i] = previous_val + 1;
            }
        }

        // If we successfully processed all elements, the array can be made strictly increasing.
        return true;
    }
}