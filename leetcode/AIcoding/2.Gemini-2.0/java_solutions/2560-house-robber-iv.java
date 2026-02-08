class Solution {
    public int minCapability(int[] nums, int k) {
        int left = 1, right = 1000000000;
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

    private boolean canRob(int[] nums, int k, int maxRob) {
        int count = 0;
        boolean robbedPrevious = false;
        for (int num : nums) {
            if (num <= maxRob && !robbedPrevious) {
                count++;
                robbedPrevious = true;
            } else {
                robbedPrevious = false;
            }
        }
        return count >= k;
    }
}