import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

class Solution {
    private int[] nums;
    private int n;
    private int groupSize;
    private int[] subsetIncompatibility;

    public int minimumIncompatibility(int[] nums, int k) {
        this.nums = nums;
        this.n = nums.length;
        this.groupSize = n / k;

        // Step 1: Precompute incompatibility for all valid subsets of size `groupSize`.
        // A subset is valid if all its elements are unique.
        this.subsetIncompatibility = new int[1 << n];
        Arrays.fill(subsetIncompatibility, -1); // -1 indicates an invalid subset (duplicate elements or wrong size)

        for (int mask = 1; mask < (1 << n); mask++) {
            if (Integer.bitCount(mask) != groupSize) {
                continue; // Only consider masks with `groupSize` elements
            }

            Set<Integer> currentGroupElements = new HashSet<>();
            int minVal = Integer.MAX_VALUE;
            int maxVal = Integer.MIN_VALUE;
            boolean hasDuplicate = false;

            for (int i = 0; i < n; i++) {
                if (((mask >> i) & 1) == 1) { // If i-th element is in the current mask
                    if (currentGroupElements.contains(nums[i])) {
                        hasDuplicate = true;
                        break; // Duplicate found, this subset is invalid
                    }
                    currentGroupElements.add(nums[i]);
                    minVal = Math.min(minVal, nums[i]);
                    maxVal = Math.max(maxVal, nums[i]);
                }
            }

            if (!hasDuplicate) {
                subsetIncompatibility[mask] = maxVal - minVal;
            }
        }

        // Step 2: Dynamic Programming with Bitmasking
        // dp[mask] stores the minimum incompatibility to partition elements represented by 'mask'
        int[] dp = new int[1 << n];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0; // Base case: no elements, no incompatibility

        // Iterate through all possible masks from 1 to (1 << n) - 1
        for (int mask = 1; mask < (1 << n); mask++) {
            // Iterate through all submasks 'sub' of 'mask'.
            // 'sub' represents the *last* group formed to reach 'mask'.
            for (int sub = mask; sub > 0; sub = (sub - 1) & mask) {
                // Check if 'sub' is a valid group (correct size, no duplicates).
                // 'subsetIncompatibility[sub]' will be -1 if it's not a valid group.
                if (subsetIncompatibility[sub] != -1) {
                    int prevMask = mask ^ sub; // Elements remaining after forming 'sub'
                    // If 'prevMask' is a reachable state (i.e., its dp value is not MAX_VALUE)
                    if (dp[prevMask] != Integer.MAX_VALUE) {
                        dp[mask] = Math.min(dp[mask], dp[prevMask] + subsetIncompatibility[sub]);
                    }
                }
            }
        }

        int result = dp[(1 << n) - 1]; // The final answer is for the mask representing all elements
        return result == Integer.MAX_VALUE ? -1 : result; // If MAX_VALUE, no valid partition exists
    }
}