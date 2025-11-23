class Solution {
    public int validSubarraySize(int[] nums, int threshold) {
        int n = nums.length;
        for (int len = 1; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int minVal = Integer.MAX_VALUE;
                for (int j = i; j < i + len; j++) {
                    minVal = Math.min(minVal, nums[j]);
                }
                if (minVal > (double)threshold / len) {
                    return len;
                }
            }
        }
        return -1;
    }
}