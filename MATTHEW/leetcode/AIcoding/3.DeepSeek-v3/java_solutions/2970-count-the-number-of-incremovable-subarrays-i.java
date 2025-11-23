class Solution {
    public int incremovableSubarrayCount(int[] nums) {
        int n = nums.length;
        int count = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                if (isIncremovable(nums, i, j)) {
                    count++;
                }
            }
        }
        return count;
    }

    private boolean isIncremovable(int[] nums, int left, int right) {
        int prev = -1;
        for (int i = 0; i < nums.length; i++) {
            if (i >= left && i <= right) {
                continue;
            }
            if (nums[i] <= prev) {
                return false;
            }
            prev = nums[i];
        }
        return true;
    }
}