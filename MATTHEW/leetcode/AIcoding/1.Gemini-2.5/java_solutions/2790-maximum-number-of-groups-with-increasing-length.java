import java.util.Arrays;

class Solution {
    public int maxIncreasingGroups(int[] usageLimits) {
        // Sort the usage limits in ascending order.
        // This greedy strategy works by trying to satisfy smaller groups first
        // using items with smaller usage limits, thus preserving items with
        // larger usage limits for potentially more demanding (larger) groups
        // or for being used multiple times across different groups.
        Arrays.sort(usageLimits);

        long currentSumOfLimits = 0; // Accumulates the total number of item uses available from types processed so far.
        int groupsFormed = 0;       // Counts the number of groups successfully formed (1-indexed: Group 1, Group 2, ...).

        // Iterate through each distinct item type, sorted by their usage limits.
        for (int limit : usageLimits) {
            currentSumOfLimits += limit; // Add the current item type's usage count to our total available "item slots".

            // Check if we have enough total item slots (currentSumOfLimits)
            // to form the next group, which would be of size (groupsFormed + 1).
            // The distinctness requirement for the (groupsFormed + 1)-th group
            // is implicitly handled because we are iterating through distinct item types.
            // At any point, 'groupsFormed + 1' will be less than or equal to the number of distinct
            // item types we have considered so far in the loop (i.e., 'i+1' in a 0-indexed loop).
            if (currentSumOfLimits >= (groupsFormed + 1)) {
                groupsFormed++; // Successfully formed the next group.
                // We don't subtract from currentSumOfLimits here because the problem allows
                // items to be used multiple times across different groups. currentSumOfLimits
                // represents the total capacity from the types considered, and we are just
                // checking if this capacity is sufficient to "fund" the next group.
                // The actual "spending" is conceptual; we just need to ensure the cumulative
                // capacity meets the cumulative demand.
            }
        }

        // The final value of groupsFormed is the maximum number of groups that can be formed.
        return groupsFormed;
    }
}