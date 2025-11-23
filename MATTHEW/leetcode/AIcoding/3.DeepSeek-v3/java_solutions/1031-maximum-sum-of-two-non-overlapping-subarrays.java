class Solution {
    public int maxSumTwoNoOverlap(int[] nums, int firstLen, int secondLen) {
        int[] prefixSum = new int[nums.length + 1];
        for (int i = 0; i < nums.length; i++) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }
        return Math.max(maxSum(prefixSum, firstLen, secondLen), maxSum(prefixSum, secondLen, firstLen));
    }

    private int maxSum(int[] prefixSum, int L, int M) {
        int maxL = 0;
        int res = 0;
        for (int i = L + M; i < prefixSum.length; i++) {
            maxL = Math.max(maxL, prefixSum[i - M] - prefixSum[i - M - L]);
            res = Math.max(res, maxL + prefixSum[i] - prefixSum[i - M]);
        }
        return res;
    }
}