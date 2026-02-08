class Solution {
    public int minChanges(int[] nums, int k) {
        int n = nums.length;
        int nHalf = n / 2;

        // zero_changes[X] stores the number of pairs (nums[i], nums[n-1-i])
        // such that nums[i] + nums[n-1-i] == X.
        // The possible sum X ranges from 2 (1+1) to 2*k (k+k).
        // Array size 2*k + 1 to cover indices up to 2*k.
        int[] zeroChanges = new int[2 * k + 1];

        // one_change_bounds is a sweep-line array.
        // For each pair (a, b), the range of sums [1+min(a,b), k+max(a,b)]
        // allows achieving the target sum X with one change (or zero if X=a+b).
        // We increment at the start of this range and decrement after the end.
        // The range for X is [2, 2*k]. The upper bound for an increment is 1+min(a,b) (min 2).
        // The upper bound for a decrement is k+max(a,b)+1 (max k+k+1 = 2k+1).
        // Array size 2*k + 2 to cover indices up to 2*k+1.
        int[] oneChangeBounds = new int[2 * k + 2];

        for (int i = 0; i < nHalf; i++) {
            int a = nums[i];
            int b = nums[n - 1 - i];

            // Ensure a <= b for min/max calculations
            if (a > b) {
                int temp = a;
                a = b;
                b = temp;
            }

            // Count pairs where the sum is already X (0 changes needed)
            zeroChanges[a + b]++;

            // Mark the start of the range where 1 change is sufficient
            // This range is [1 + min(a,b), k + max(a,b)]
            oneChangeBounds[1 + a]++;
            // Mark the end of the range (exclusive)
            oneChangeBounds[k + b + 1]--;
        }

        int minOverallChanges = Integer.MAX_VALUE;
        // currentOneChangePairs tracks how many pairs can be fixed with 0 or 1 change
        // for the current target sum X.
        int currentOneChangePairs = 0;

        // Iterate through all possible target sums X from 2 to 2*k
        for (int x = 2; x <= 2 * k; x++) {
            // Update the count of pairs that can be fixed with 0 or 1 change.
            // This is the sweep line part: adding/removing pairs based on their ranges.
            currentOneChangePairs += oneChangeBounds[x];

            // Calculate total changes for the current target sum X.
            //
            // Initial assumption: all nHalf pairs need 2 changes.
            // Cost = 2 * nHalf
            //
            // Then, for pairs that can be fixed with 0 or 1 change (currentOneChangePairs),
            // we reduce the cost by 1 for each such pair.
            // Cost -= currentOneChangePairs
            // (Now, pairs needing 2 changes contribute 2, pairs needing 1 change contribute 1,
            //  pairs needing 0 changes still contribute 1.)
            //
            // Finally, for pairs that actually need 0 changes (zeroChanges[x]),
            // we further reduce the cost by 1 for each such pair.
            // Cost -= zeroChanges[x]
            // (Now, pairs needing 2 changes contribute 2, pairs needing 1 change contribute 1,
            //  pairs needing 0 changes contribute 0.)
            int currentTotalChanges = 2 * nHalf - currentOneChangePairs - zeroChanges[x];

            minOverallChanges = Math.min(minOverallChanges, currentTotalChanges);
        }

        return minOverallChanges;
    }
}