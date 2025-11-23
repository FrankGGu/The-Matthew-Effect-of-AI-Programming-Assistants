class Solution {
    public int maximumAmount(int[] nums, int k) {
        int n = nums.length;
        if (n == 0 || k == 0) return 0;

        int[] leftMax = new int[n];
        int[] rightMax = new int[n];

        leftMax[0] = nums[0];
        for (int i = 1; i < n; i++) {
            leftMax[i] = Math.max(leftMax[i - 1], nums[i]);
        }

        rightMax[n - 1] = nums[n - 1];
        for (int i = n - 2; i >= 0; i--) {
            rightMax[i] = Math.max(rightMax[i + 1], nums[i]);
        }

        int maxAmount = 0;
        for (int i = 0; i < n; i++) {
            if (i < k) {
                int current = nums[i] + rightMax[i + 1];
                maxAmount = Math.max(maxAmount, current);
            }
        }

        return maxAmount;
    }
}