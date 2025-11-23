class Solution {
    public int minCapability(int[] nums, int k) {
        int left = 1;
        int right = 0;
        for (int num : nums) {
            right = Math.max(right, num);
        }

        while (left < right) {
            int mid = left + (right - left) / 2;
            if (canSteal(nums, k, mid)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        return left;
    }

    private boolean canSteal(int[] nums, int k, int cap) {
        int stolen = 0;
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] <= cap) {
                stolen++;
                i++;
            }
        }
        return stolen >= k;
    }
}