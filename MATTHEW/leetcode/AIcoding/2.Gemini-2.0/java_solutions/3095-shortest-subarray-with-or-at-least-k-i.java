class Solution {
    public int shortestSubarray(int[] nums, int k) {
        int n = nums.length;
        int ans = n + 1;
        long[] prefixSum = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j <= n; j++) {
                long orVal = 0;
                for (int l = i; l < j; l++) {
                    orVal |= nums[l];
                }
                if (orVal >= k) {
                    ans = Math.min(ans, j - i);
                }
            }
        }

        return ans > n ? -1 : ans;
    }
}