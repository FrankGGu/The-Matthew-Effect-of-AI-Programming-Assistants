class Solution {
    public boolean canJump(int[] nums) {
        int n = nums.length;
        int maxReach = 0; // The maximum index that can be reached so far

        for (int i = 0; i < n; i++) {
            // If the current index 'i' is beyond the maximum reach,
            // it means we cannot reach this position, and thus cannot reach the end.
            if (i > maxReach) {
                return false;
            }

            // Update the maximum index that can be reached
            maxReach = Math.max(maxReach, i + nums[i]);

            // If the maximum reach is already at or beyond the last index,
            // we can definitely reach the end.
            if (maxReach >= n - 1) {
                return true;
            }
        }

        // This line should technically not be reached if the logic is correct,
        // because either 'true' is returned if the end is reachable,
        // or 'false' is returned if 'i' exceeds 'maxReach'.
        // However, for completeness, if the loop finishes without returning true,
        // it means maxReach never reached n-1, and we never got stuck before n-1.
        // This implies that maxReach was always less than n-1.
        // But the `if (maxReach >= n - 1)` check covers this.
        // So, if the loop completes, it means `maxReach` was never `n-1` or greater.
        // This implies `false`.
        return false; 
    }
}