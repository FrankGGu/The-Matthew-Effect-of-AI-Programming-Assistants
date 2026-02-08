class Solution {
    public int sumOfBeauty(int[] nums) {
        int n = nums.length;
        int beautySum = 0;

        for (int i = 1; i < n - 1; i++) {
            int leftMax = Math.max(nums[i - 1], nums[i]);
            int rightMax = Math.max(nums[i], nums[i + 1]);
            int leftMin = Math.min(nums[i - 1], nums[i]);
            int rightMin = Math.min(nums[i], nums[i + 1]);

            if (leftMax > rightMax) {
                beautySum += 1;
            }
            if (leftMin < rightMin) {
                beautySum += 1;
            }
        }

        return beautySum;
    }
}