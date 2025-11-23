class Solution {
    public long[] getPower(int[] nums, int k) {
        int n = nums.length;
        long[] result = new long[n - k + 1];

        for (int i = 0; i <= n - k; i++) {
            long min = Long.MAX_VALUE;
            for (int j = i; j < i + k; j++) {
                if (nums[j] < min) {
                    min = nums[j];
                }
            }
            result[i] = min * min * min;
        }

        return result;
    }
}