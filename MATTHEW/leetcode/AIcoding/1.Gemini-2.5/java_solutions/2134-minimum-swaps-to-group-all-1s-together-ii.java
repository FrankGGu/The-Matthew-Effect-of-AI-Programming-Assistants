class Solution {
    public int minSwaps(int[] nums) {
        int n = nums.length;

        int totalOnes = 0;
        for (int num : nums) {
            if (num == 1) {
                totalOnes++;
            }
        }

        if (totalOnes == 0) {
            return 0;
        }

        int currentOnesInWindow = 0;
        for (int i = 0; i < totalOnes; i++) {
            if (nums[i] == 1) {
                currentOnesInWindow++;
            }
        }

        int maxOnesInWindow = currentOnesInWindow;

        for (int i = 1; i < n; i++) {
            if (nums[i - 1] == 1) {
                currentOnesInWindow--;
            }
            if (nums[(i + totalOnes - 1) % n] == 1) {
                currentOnesInWindow++;
            }
            maxOnesInWindow = Math.max(maxOnesInWindow, currentOnesInWindow);
        }

        return totalOnes - maxOnesInWindow;
    }
}