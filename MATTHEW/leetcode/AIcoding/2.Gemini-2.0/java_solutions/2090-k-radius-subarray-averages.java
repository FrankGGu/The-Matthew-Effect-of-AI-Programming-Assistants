class Solution {
    public int[] getAverages(int[] nums, int k) {
        int n = nums.length;
        int[] averages = new int[n];
        long[] prefixSum = new long[n + 1];

        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        for (int i = 0; i < n; i++) {
            if (i - k < 0 || i + k >= n) {
                averages[i] = -1;
            } else {
                long sum = prefixSum[i + k + 1] - prefixSum[i - k];
                averages[i] = (int) (sum / (2 * k + 1));
            }
        }

        return averages;
    }
}