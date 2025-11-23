import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

class Solution {
    public int earliestSecondToMarkIndices(int[] nums, int[][] changeIndices) {
        int n = nums.length;
        int m = changeIndices.length;

        // The minimum possible time is 'n' (to mark n indices, each taking 1 second).
        // The maximum possible time is 'm' (using all available operations).
        int low = n;
        int high = m;
        int ans = -1;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (check(nums, changeIndices, n, mid)) {
                ans = mid;
                high = mid - 1; // Try to find an earlier time
            } else {
                low = mid + 1; // Need more time
            }
        }

        return ans;
    }

    // This function checks if it's possible to mark all 'n' indices within 't' seconds.
    private boolean check(int[] nums, int[][] changeIndices, int n, int t) {
        // We consider operations from changeIndices[0] to changeIndices[t-1].

        // `indicesToMark` keeps track of which 1-based indices still need to be marked.
        // We initialize it with all 'n' indices.
        Set<Integer> indicesToMark = new HashSet<>();
        for (int i = 1; i <= n; i++) {
            indicesToMark.add(i);
        }

        // `totalDecrementsNeeded` accumulates the sum of nums[idx-1] for indices we commit to mark.
        long totalDecrementsNeeded = 0;
        // `availableDecrementSlots` counts operations that can be used for decrementing.
        long availableDecrementSlots = 0;

        // Iterate through the first 't' operations in reverse order.
        // This greedy strategy ensures that for each index 'idx', if we choose to mark it,
        // we use its latest possible 'mark' operation (val=1) within the 't' seconds.
        // This frees up earlier slots for decrementing other nums values.
        for (int k = t - 1; k >= 0; k--) {
            int idx = changeIndices[k][0]; // 1-based index
            int val = changeIndices[k][1];

            // If this operation is a 'mark' operation (val=1) for an index that still needs to be marked:
            if (val == 1 && indicesToMark.contains(idx)) {
                // We commit to marking this index 'idx' using this operation at second 'k+1'.
                // This slot 'k' is consumed by the mark operation and cannot be used for decrementing.
                indicesToMark.remove(idx);
                // We add the initial value of nums[idx-1] to the total decrements needed.
                totalDecrementsNeeded += nums[idx - 1];
            } else {
                // This slot 'k' is either a 'decrement' operation (val=0)
                // or a 'mark' operation (val=1) for an index that has already been committed to be marked
                // by a later operation (because we are iterating backwards).
                // In either case, this slot can be used for decrementing some nums value.
                availableDecrementSlots++;
            }
        }

        // After processing all relevant operations:
        // If `indicesToMark` is not empty, it means we couldn't find a 'mark' operation for all 'n' indices.
        // Therefore, 't' is not feasible.
        if (!indicesToMark.isEmpty()) {
            return false;
        }

        // If all indices can be marked, check if we have enough available slots for all needed decrements.
        return availableDecrementSlots >= totalDecrementsNeeded;
    }
}