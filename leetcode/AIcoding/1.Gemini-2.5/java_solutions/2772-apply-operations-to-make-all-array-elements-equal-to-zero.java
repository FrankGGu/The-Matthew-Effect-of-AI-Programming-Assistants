class Solution {
    public boolean checkArray(int[] nums, int k) {
        int n = nums.length;
        long currentDecrement = 0;
        long[] startOps = new long[n];

        for (int i = 0; i < n; i++) {
            if (i >= k) {
                currentDecrement -= startOps[i - k];
            }

            long effectiveVal = nums[i] - currentDecrement;

            if (effectiveVal < 0) {
                return false;
            }

            if (effectiveVal > 0) {
                if (i + k > n) {
                    return false;
                }
                startOps[i] = effectiveVal;
                currentDecrement += effectiveVal;
            }
        }

        return true;
    }
}