class Solution {
    public int minimizeArrayValue(int[] nums) {
        int left = 0, right = Integer.MIN_VALUE;
        for (int num : nums) {
            right = Math.max(right, num);
        }

        while (left < right) {
            int mid = left + (right - left) / 2;
            if (canDistribute(nums, mid)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        return left;
    }

    private boolean canDistribute(int[] nums, int max) {
        long sum = 0;
        for (int num : nums) {
            sum += Math.min(num, max);
        }
        return sum <= (long) max * nums.length;
    }
}