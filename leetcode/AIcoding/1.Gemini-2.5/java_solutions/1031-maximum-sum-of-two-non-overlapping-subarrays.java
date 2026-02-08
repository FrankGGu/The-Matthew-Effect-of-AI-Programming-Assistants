class Solution {
    public int maxSumTwoNoOverlap(int[] nums, int firstLen, int secondLen) {
        return Math.max(solve(nums, firstLen, secondLen), solve(nums, secondLen, firstLen));
    }

    private int solve(int[] nums, int L, int M) {
        int n = nums.length;
        int[] prefixSum = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        int maxLsum = 0;
        int ans = 0;

        for (int i = L + M - 1; i < n; i++) {
            // Calculate sum of L-length subarray ending at index `i - M`.
            // The indices for this L-length subarray are [i - M - L + 1, i - M].
            // Its sum is prefixSum[(i - M) + 1] - prefixSum[(i - M - L + 1)].
            int currentLsum = prefixSum[i - M + 1] - prefixSum[i - M - L + 1];
            maxLsum = Math.max(maxLsum, currentLsum);

            // Calculate sum of M-length subarray ending at index `i`.
            // The indices for this M-length subarray are [i - M + 1, i].
            // Its sum is prefixSum[i + 1] - prefixSum[i - M + 1].
            int currentMsum = prefixSum[i + 1] - prefixSum[i - M + 1];

            ans = Math.max(ans, maxLsum + currentMsum);
        }

        return ans;
    }
}