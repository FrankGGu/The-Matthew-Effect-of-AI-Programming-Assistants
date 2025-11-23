class Solution {
    public int minimumDeletions(int[] nums) {
        int n = nums.length;

        if (n == 1) {
            return 1;
        }

        int minVal = nums[0];
        int maxVal = nums[0];
        int minIdx = 0;
        int maxIdx = 0;

        for (int i = 0; i < n; i++) {
            if (nums[i] < minVal) {
                minVal = nums[i];
                minIdx = i;
            }
            if (nums[i] > maxVal) {
                maxVal = nums[i];
                maxIdx = i;
            }
        }

        int closerIdx = Math.min(minIdx, maxIdx);
        int furtherIdx = Math.max(minIdx, maxIdx);

        // Option 1: Remove both from the front
        // This means deleting all elements from index 0 up to furtherIdx (inclusive).
        int deletionsFromFront = furtherIdx + 1;

        // Option 2: Remove both from the back
        // This means deleting all elements from closerIdx up to n-1 (inclusive).
        int deletionsFromBack = n - closerIdx;

        // Option 3: Remove one from the front and one from the back
        // This means deleting elements from 0 up to closerIdx (inclusive)
        // AND deleting elements from furtherIdx up to n-1 (inclusive).
        int deletionsFromBothEnds = (closerIdx + 1) + (n - furtherIdx);

        return Math.min(deletionsFromFront, Math.min(deletionsFromBack, deletionsFromBothEnds));
    }
}