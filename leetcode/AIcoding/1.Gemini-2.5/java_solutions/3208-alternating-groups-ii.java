class Solution {
    public int numberOfAlternatingGroups(int[] colors, int k) {
        int n = colors.length;

        if (k == 1) {
            // For k=1, a group consists of a single chair.
            // Condition 1 (adjacent chairs different) is vacuously true.
            // Condition 2 (first and last chairs different) becomes C_0 != C_0, which is always false.
            // Thus, no group can be alternating if k=1.
            return 0;
        }

        // Create an extended array to handle circularity without modulo operations in the main loop.
        // We need 'k-1' additional elements to check the 'k' chairs for each starting position 'i' up to 'n-1'.
        // The total length required for extendedColors is n + (k-1).
        int[] extendedColors = new int[n + k - 1];
        for (int i = 0; i < n + k - 1; i++) {
            extendedColors[i] = colors[i % n];
        }

        // Create an array to mark if adjacent chairs are different.
        // diffs[j] = 1 if extendedColors[j] != extendedColors[j+1], else 0.
        // This array will have length (n + k - 1) - 1 = n + k - 2.
        int[] diffs = new int[n + k - 2];
        for (int i = 0; i < n + k - 2; i++) {
            if (extendedColors[i] != extendedColors[i+1]) {
                diffs[i] = 1;
            } else {
                diffs[i] = 0;
            }
        }

        // Create a prefix sum array for 'diffs' to efficiently calculate sums over windows.
        // prefixSumDiffs[j] stores the sum of diffs[0]...diffs[j-1].
        // Its length will be (n + k - 2) + 1 = n + k - 1.
        int[] prefixSumDiffs = new int[n + k - 1];
        prefixSumDiffs[0] = 0;
        for (int i = 1; i < n + k - 1; i++) {
            prefixSumDiffs[i] = prefixSumDiffs[i-1] + diffs[i-1];
        }

        int alternatingGroupsCount = 0;

        // Iterate through all possible starting positions 'i' in the original 'colors' array.
        for (int i = 0; i < n; i++) {
            // For a group starting at 'i' (using extendedColors):
            // The chairs are extendedColors[i], extendedColors[i+1], ..., extendedColors[i+k-1].

            // Condition 1: Check if all adjacent chairs within the group are different.
            // This means diffs[i], diffs[i+1], ..., diffs[i+k-2] must all be 1.
            // Sum of these (k-1) elements must be equal to k-1.
            int sumAdjacentDifferences = prefixSumDiffs[i + k - 1] - prefixSumDiffs[i];
            boolean condition1Met = (sumAdjacentDifferences == k - 1);

            // Condition 2: Check if the first and last chairs in the group are different.
            // This means extendedColors[i] != extendedColors[i+k-1].
            boolean condition2Met = (extendedColors[i] != extendedColors[i + k - 1]);

            if (condition1Met && condition2Met) {
                alternatingGroupsCount++;
            }
        }

        return alternatingGroupsCount;
    }
}