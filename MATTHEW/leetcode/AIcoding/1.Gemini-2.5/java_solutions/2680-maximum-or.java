class Solution {
    public long maximumOr(int[] nums, int k) {
        int n = nums.length;
        long[] prefixOR = new long[n + 1];
        long[] suffixOR = new long[n + 1];

        prefixOR[0] = 0;
        for (int i = 0; i < n; i++) {
            prefixOR[i + 1] = prefixOR[i] | nums[i];
        }

        suffixOR[n] = 0;
        for (int i = n - 1; i >= 0; i--) {
            suffixOR[i] = suffixOR[i + 1] | nums[i];
        }

        long maxOR = 0;

        for (int i = 0; i < n; i++) {
            long currentNumShifted = (long) nums[i] << k;
            long currentOR = prefixOR[i] | currentNumShifted | suffixOR[i + 1];
            if (currentOR > maxOR) {
                maxOR = currentOR;
            }
        }

        return maxOR;
    }
}