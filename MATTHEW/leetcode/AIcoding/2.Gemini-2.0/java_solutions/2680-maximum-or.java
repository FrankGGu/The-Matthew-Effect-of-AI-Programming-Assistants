class Solution {
    public long maximumOr(int[] nums, int k) {
        int n = nums.length;
        long[] prefix = new long[n];
        long[] suffix = new long[n];

        prefix[0] = nums[0];
        for (int i = 1; i < n; i++) {
            prefix[i] = prefix[i - 1] | nums[i];
        }

        suffix[n - 1] = nums[n - 1];
        for (int i = n - 2; i >= 0; i--) {
            suffix[i] = suffix[i + 1] | nums[i];
        }

        long ans = 0;
        for (int i = 0; i < n; i++) {
            long currentOr = (long) nums[i] << k;
            if (i > 0) {
                currentOr |= prefix[i - 1];
            }
            if (i < n - 1) {
                currentOr |= suffix[i + 1];
            }
            ans = Math.max(ans, currentOr);
        }

        return ans;
    }
}