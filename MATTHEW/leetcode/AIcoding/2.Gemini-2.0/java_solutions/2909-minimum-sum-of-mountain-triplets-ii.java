class Solution {
    public int minimumSum(int[] nums) {
        int n = nums.length;
        int[] leftMin = new int[n];
        int[] rightMin = new int[n];

        leftMin[0] = nums[0];
        for (int i = 1; i < n; i++) {
            leftMin[i] = Math.min(leftMin[i - 1], nums[i]);
        }

        rightMin[n - 1] = nums[n - 1];
        for (int i = n - 2; i >= 0; i--) {
            rightMin[i] = Math.min(rightMin[i + 1], nums[i]);
        }

        int ans = Integer.MAX_VALUE;
        for (int i = 1; i < n - 1; i++) {
            if (nums[i] > leftMin[i - 1] && nums[i] > rightMin[i + 1]) {
                ans = Math.min(ans, leftMin[i - 1] + nums[i] + rightMin[i + 1]);
            }
        }

        return ans == Integer.MAX_VALUE ? -1 : ans;
    }
}