class Solution {
    public int smallestDivisor(int[] nums, int threshold) {
        int left = 1, right = Integer.MAX_VALUE;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (calculateSum(nums, mid) > threshold) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }

    private int calculateSum(int[] nums, int divisor) {
        int sum = 0;
        for (int num : nums) {
            sum += (num + divisor - 1) / divisor;
        }
        return sum;
    }
}