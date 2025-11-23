class Solution {
    public long countMonotonicPairs(int[] nums) {
        int n = nums.length;
        long count = 0;
        long[] prefixInc = new long[n];
        long[] prefixDec = new long[n];

        for (int i = 0; i < n; i++) {
            if (i == 0 || nums[i] >= nums[i - 1]) {
                prefixInc[i] = (i == 0 ? 0 : prefixInc[i - 1]) + 1;
            } else {
                prefixInc[i] = 1;
            }
        }

        for (int i = n - 1; i >= 0; i--) {
            if (i == n - 1 || nums[i] <= nums[i + 1]) {
                prefixDec[i] = (i == n - 1 ? 0 : prefixDec[i + 1]) + 1;
            } else {
                prefixDec[i] = 1;
            }
        }

        for (int i = 0; i < n; i++) {
            count += prefixInc[i] + prefixDec[i] - 1;
        }

        return count;
    }
}