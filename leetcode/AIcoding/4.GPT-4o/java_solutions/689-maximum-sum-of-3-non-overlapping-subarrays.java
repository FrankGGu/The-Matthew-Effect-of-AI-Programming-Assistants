class Solution {
    public int maxSumOfThreeSubarrays(int[] nums, int k) {
        int n = nums.length;
        int[] sum = new int[n + 1];
        for (int i = 0; i < n; i++) {
            sum[i + 1] = sum[i] + nums[i];
        }

        int[] left = new int[n];
        int maxSum = 0, maxIndex = 0;
        for (int i = k - 1; i < n; i++) {
            if (sum[i + 1] - sum[i + 1 - k] > maxSum) {
                maxSum = sum[i + 1] - sum[i + 1 - k];
                maxIndex = i + 1 - k;
            }
            left[i] = maxIndex;
        }

        int[] right = new int[n];
        maxSum = 0;
        maxIndex = n - k;
        for (int i = n - k; i >= 0; i--) {
            if (sum[i + k] - sum[i] >= maxSum) {
                maxSum = sum[i + k] - sum[i];
                maxIndex = i;
            }
            right[i] = maxIndex;
        }

        int result = 0;
        for (int j = k - 1; j < n - k; j++) {
            int leftIndex = left[j];
            int rightIndex = right[j + 1];
            result = Math.max(result, (sum[leftIndex + k] - sum[leftIndex]) + (sum[rightIndex + k] - sum[rightIndex]) + (sum[j + 1] - sum[j + 1 - k]));
        }

        return result;
    }
}