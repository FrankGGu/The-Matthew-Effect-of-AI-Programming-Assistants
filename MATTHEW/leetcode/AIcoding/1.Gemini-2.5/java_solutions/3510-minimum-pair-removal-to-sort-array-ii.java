import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public int minPairRemovalToSortArrayII(int[] nums) {
        if (nums == null || nums.length == 0) {
            return 0;
        }

        List<Integer> tails = new ArrayList<>();
        for (int num : nums) {
            // Find the index 'idx' of the first element in 'tails' that is greater than or equal to 'num'.
            // This is the lower_bound operation for a non-decreasing sequence.
            // Collections.binarySearch returns:
            //   - a non-negative index if 'num' is found in 'tails'.
            //   - (-(insertion point) - 1) if 'num' is not found.
            // The 'insertion point' is the index where 'num' would be inserted to maintain sorted order,
            // i.e., the index of the first element strictly greater than 'num', or tails.size() if all elements are less than 'num'.
            // For LNDS, if 'num' is found, we can replace it. If not found, the insertion point is where it would go.
            // This behavior correctly identifies the position to update or extend the 'tails' array for LNDS.
            int idx = Collections.binarySearch(tails, num);

            if (idx < 0) {
                // 'num' is not found. Convert the negative result to the insertion point.
                idx = -(idx + 1);
            }
            // At this point, 'idx' is the correct position:
            // - If 'num' was found, 'idx' is its index.
            // - If 'num' was not found, 'idx' is the index of the first element greater than 'num'.
            //   If no such element exists, 'idx' is tails.size().

            if (idx == tails.size()) {
                // 'num' is greater than all existing tails, so it extends the longest non-decreasing subsequence.
                tails.add(num);
            } else {
                // 'num' can replace an existing tail to potentially form a shorter or same-length subsequence
                // ending with a smaller value, which is beneficial for future elements.
                tails.set(idx, num);
            }
        }

        int longestNonDecreasingSubsequenceLength = tails.size();
        int n = nums.length;
        int removals = n - longestNonDecreasingSubsequenceLength;

        // The problem asks for "Minimum Pair Removal".
        // If 'removals' elements need to be removed, and each "pair removal" removes 2 elements,
        // we need to find the minimum number of pairs.
        // This is equivalent to ceil(removals / 2.0).
        // Using integer division, (removals + 1) / 2 achieves this:
        // If removals = 0, (0 + 1) / 2 = 0
        // If removals = 1, (1 + 1) / 2 = 1
        // If removals = 2, (2 + 1) / 2 = 1
        // If removals = 3, (3 + 1) / 2 = 2
        return (removals + 1) / 2;
    }
}