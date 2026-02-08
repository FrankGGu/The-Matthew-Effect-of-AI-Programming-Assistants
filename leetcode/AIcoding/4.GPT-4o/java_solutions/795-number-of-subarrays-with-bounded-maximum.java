class Solution {
    public int numSubarrayBoundedMax(int[] nums, int left, int right) {
        return count(nums, right) - count(nums, left - 1);
    }

    private int count(int[] nums, int bound) {
        int total = 0, count = 0;
        for (int num : nums) {
            if (num <= bound) {
                count++;
                total += count;
            } else {
                count = 0;
            }
        }
        return total;
    }
}