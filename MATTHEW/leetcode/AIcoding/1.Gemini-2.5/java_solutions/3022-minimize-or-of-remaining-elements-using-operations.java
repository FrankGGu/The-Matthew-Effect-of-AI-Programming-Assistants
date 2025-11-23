class Solution {
    public int minimizeOr(int[] nums, int k) {
        int maxVal = 0;
        for (int num : nums) {
            maxVal = Math.max(maxVal, num);
        }

        int low = 0;
        int high = maxVal;
        int ans = maxVal;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (check(nums, k, mid)) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return ans;
    }

    private boolean check(int[] nums, int k, int targetOr) {
        int segments = 0;
        int currentAnd = (1 << 30) - 1; // Represents all bits set, initial value for AND operation

        for (int num : nums) {
            currentAnd &= num;
            // If the current segment's AND value is a submask of targetOr,
            // it means this segment can contribute to achieving targetOr.
            // So, we can "cut" the array here and start a new segment.
            if ((currentAnd | targetOr) == targetOr) {
                segments++;
                currentAnd = (1 << 30) - 1; // Reset for the next segment
            }
        }

        // After iterating through all numbers, if currentAnd is not (1 << 30) - 1,
        // it means the last segment (or the entire array if no cuts were made)
        // did not result in an AND value that is a submask of targetOr.
        // In this case, targetOr is not achievable.
        if (currentAnd != (1 << 30) - 1) {
            return false;
        }

        // We need 'segments' blocks. To create 'segments' blocks, we need 'segments - 1' operations.
        // The problem states "at most k operations". So, segments - 1 <= k, or segments <= k + 1.
        return segments <= k + 1;
    }
}