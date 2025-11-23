class Solution {
    public long incremovableSubarrayCount(int[] nums) {
        int n = nums.length;
        long ans = 0;

        if (n == 0) {
            return 0;
        }

        // j_ptr will be the smallest index k such that nums[k...n-1] is strictly increasing.
        // If n=0, this concept is not applicable, handled by early return.
        // If n=1, nums[0...0] is strictly increasing, so j_ptr = 0.
        int j_ptr = n - 1;
        while (j_ptr > 0 && nums[j_ptr - 1] < nums[j_ptr]) {
            j_ptr--;
        }
        // After this loop, nums[j_ptr...n-1] is strictly increasing.

        // Iterate i from 0 to n (inclusive).
        // i represents the starting index of the subarray to be removed (nums[i...j]).
        // The prefix nums[0...i-1] must be strictly increasing.
        for (int i = 0; i <= n; i++) {
            // Condition 1: Check if nums[0...i-1] is strictly increasing.
            // If i=0, the prefix is empty, which is strictly increasing.
            // If i > 1, check nums[i-2] against nums[i-1].
            if (i > 1 && nums[i - 2] >= nums[i - 1]) {
                // If nums[0...i-1] is not strictly increasing,
                // then any further 'i' values will also not have a strictly increasing prefix.
                // So, we can break the loop.
                break;
            }

            // Now, nums[0...i-1] is strictly increasing.
            // We need to find valid 'j' such that i <= j < n.
            // Condition 2: nums[j+1...n-1] must be strictly increasing.
            // This implies that j+1 must be greater than or equal to j_ptr (the start of the valid suffix).
            // So, j >= j_ptr - 1.

            // Condition 3: If i > 0 (prefix exists) and j < n-1 (suffix exists),
            // then nums[i-1] < nums[j+1].
            // We use the 'j_ptr' to satisfy this condition.
            // 'j_ptr' is the start of the suffix. We need nums[i-1] < nums[j_ptr].
            // We advance 'j_ptr' until this condition is met or 'j_ptr' reaches 'n'.
            while (j_ptr < n && (i > 0 && nums[i - 1] >= nums[j_ptr])) {
                j_ptr++;
            }
            // After this loop, j_ptr is the smallest index such that:
            // a) nums[j_ptr...n-1] is strictly increasing (due to its initial calculation and monotonic increase).
            // b) If i > 0 and j_ptr < n, then nums[i-1] < nums[j_ptr].

            // We need to count 'j' values (end index of the removed subarray) such that:
            // 1. i <= j < n (j must be within array bounds and after or at 'i')
            // 2. j >= j_ptr - 1 (to satisfy condition 2 for the suffix)
            // Combining these, 'j' must be in the range [max(i, j_ptr - 1), n - 1].

            // The number of such 'j' values is (n - 1) - max(i, j_ptr - 1) + 1.
            // This simplifies to n - Math.max(i, j_ptr - 1).
            ans += (n - Math.max(i, j_ptr - 1));
        }

        return ans;
    }
}