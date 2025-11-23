import java.util.Arrays;

class Solution {
    public long maxValueAfterReverse(int[] nums) {
        int n = nums.length;
        long initialValue = 0;
        for (int i = 0; i < n - 1; i++) {
            initialValue += Math.abs(nums[i] - nums[i + 1]);
        }

        long maxIncrease = 0;

        // Case 1: Reverse subarray starting at index 0 (nums[0...r])
        // The original term |nums[r] - nums[r+1]| is replaced by |nums[0] - nums[r+1]|.
        // The change in value is (|nums[0] - nums[r+1]| - |nums[r] - nums[r+1]|).
        for (int r = 0; r < n - 1; r++) {
            maxIncrease = Math.max(maxIncrease, Math.abs(nums[0] - nums[r + 1]) - Math.abs(nums[r] - nums[r + 1]));
        }

        // Case 2: Reverse subarray ending at index n-1 (nums[l...n-1])
        // The original term |nums[l-1] - nums[l]| is replaced by |nums[l-1] - nums[n-1]|.
        // The change in value is (|nums[l-1] - nums[n-1]| - |nums[l-1] - nums[l]|).
        for (int l = 1; l < n; l++) {
            maxIncrease = Math.max(maxIncrease, Math.abs(nums[l - 1] - nums[n - 1]) - Math.abs(nums[l - 1] - nums[l]));
        }

        // Case 3: Reverse subarray nums[l...r] where 0 < l <= r < n-1.
        // This means the reversed segment is entirely within the array, not touching the global endpoints.
        // The original terms |nums[l-1] - nums[l]| + |nums[r] - nums[r+1]|
        // are replaced by |nums[l-1] - nums[r]| + |nums[l] - nums[r+1]|.
        // The change in value is (|nums[l-1] - nums[r]| + |nums[l] - nums[r+1]|) - (|nums[l-1] - nums[l]| + |nums[r] - nums[r+1]|).
        // This expression is maximized when the two pairs (nums[l-1], nums[l]) and (nums[r], nums[r+1]) are "separated" on the number line.
        // i.e., max(nums[l-1], nums[l]) < min(nums[r], nums[r+1]) or min(nums[l-1], nums[l]) > max(nums[r], nums[r+1]).
        // The maximum gain in this scenario is 2 * (min(pair2) - max(pair1)) or 2 * (min(pair1) - max(pair2)).
        // Let (x,y) be (nums[k], nums[k+1]) and (z,w) be (nums[i], nums[i+1]) where k < i-1.
        // We want to maximize 2 * (min(z,w) - max(x,y)) or 2 * (max(x,y) - min(z,w)).

        long minOfMaxOfPrevPairs = Long.MAX_VALUE; // Stores min(max(nums[k], nums[k+1])) for k <= current_i - 2
        long maxOfMinOfPrevPairs = Long.MIN_VALUE; // Stores max(min(nums[k], nums[k+1])) for k <= current_i - 2

        for (int i = 0; i < n - 1; i++) { // `i` represents the index of the first element of the current pair (nums[i], nums[i+1])
            long currMin = Math.min(nums[i], nums[i + 1]);
            long currMax = Math.max(nums[i], nums[i + 1]);

            // When `i` is 0 or 1, there are no `k <= i-2` pairs, so no calculation.
            // When `i >= 2`, `(nums[i], nums[i+1])` can be the second pair `(z,w)`.
            // `minOfMaxOfPrevPairs` and `maxOfMinOfPrevPairs` would have been updated for `k` up to `i-2`.
            if (i >= 2) {
                // Maximize 2 * (min(current_pair) - max(previous_pair))
                maxIncrease = Math.max(maxIncrease, 2 * (currMin - minOfMaxOfPrevPairs));
                // Maximize 2 * (max(previous_pair) - min(current_pair))
                maxIncrease = Math.max(maxIncrease, 2 * (maxOfMinOfPrevPairs - currMax));
            }

            // Update `minOfMaxOfPrevPairs` and `maxOfMinOfPrevPairs` for the *next* iteration.
            // These will be used when `i+1` is the current `i`.
            // At that point, they will correctly represent values for `k` up to `(i+1)-2 = i-1`.
            minOfMaxOfPrevPairs = Math.min(minOfMaxOfPrevPairs, currMax);
            maxOfMinOfPrevPairs = Math.max(maxOfMinOfPrevPairs, currMin);
        }

        return initialValue + maxIncrease;
    }
}