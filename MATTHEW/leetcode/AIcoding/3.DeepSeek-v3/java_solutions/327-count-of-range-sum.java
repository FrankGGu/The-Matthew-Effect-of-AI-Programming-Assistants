class Solution {
    public int countRangeSum(int[] nums, int lower, int upper) {
        int n = nums.length;
        long[] prefixSum = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }
        return countRangeSumRecursive(prefixSum, lower, upper, 0, n);
    }

    private int countRangeSumRecursive(long[] prefixSum, int lower, int upper, int left, int right) {
        if (left >= right) {
            return 0;
        }
        int mid = left + (right - left) / 2;
        int count = countRangeSumRecursive(prefixSum, lower, upper, left, mid) 
                  + countRangeSumRecursive(prefixSum, lower, upper, mid + 1, right);
        int i = left;
        int j = mid + 1;
        int k = mid + 1;
        int t = mid + 1;
        long[] merged = new long[right - left + 1];
        int idx = 0;
        while (i <= mid) {
            while (j <= right && prefixSum[j] - prefixSum[i] < lower) {
                j++;
            }
            while (k <= right && prefixSum[k] - prefixSum[i] <= upper) {
                k++;
            }
            count += k - j;
            while (t <= right && prefixSum[t] < prefixSum[i]) {
                merged[idx++] = prefixSum[t++];
            }
            merged[idx++] = prefixSum[i++];
        }
        while (t <= right) {
            merged[idx++] = prefixSum[t++];
        }
        System.arraycopy(merged, 0, prefixSum, left, merged.length);
        return count;
    }
}