class Solution {
    public int[] maxSumOfThreeSubarrays(int[] nums, int k) {
        int n = nums.length;

        long[] prefixSum = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        long[] W = new long[n - k + 1];
        for (int i = 0; i <= n - k; i++) {
            W[i] = prefixSum[i + k] - prefixSum[i];
        }

        int[] left = new int[n - k + 1];
        left[0] = 0;
        for (int i = 1; i <= n - k; i++) {
            if (W[i] > W[left[i - 1]]) {
                left[i] = i;
            } else {
                left[i] = left[i - 1];
            }
        }

        int[] right = new int[n - k + 1];
        right[n - k] = n - k;
        for (int i = n - k - 1; i >= 0; i--) {
            if (W[i] >= W[right[i + 1]]) { 
                right[i] = i;
            } else {
                right[i] = right[i + 1];
            }
        }

        long maxSum = -1;
        int[] result = new int[3];

        for (int j = k; j <= n - 2 * k; j++) {
            int i = left[j - k];
            int l = right[j + k];

            long currentSum = W[i] + W[j] + W[l];

            if (currentSum > maxSum) {
                maxSum = currentSum;
                result[0] = i;
                result[1] = j;
                result[2] = l;
            }
        }

        return result;
    }
}