class Solution {
    public int minCapability(int[] nums, int k) {
        int left = 1, right = (int)1e9;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (canRob(nums, k, mid)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }

    private boolean canRob(int[] nums, int k, int max) {
        int count = 0;
        for (int i = 0; i < nums.length; ) {
            if (nums[i] <= max) {
                count++;
                i += 2;
            } else {
                i++;
            }
            if (count >= k) {
                return true;
            }
        }
        return count >= k;
    }
}