import java.util.Arrays;

public class Solution {
    public int countRangeSum(int[] nums, int lower, int upper) {
        int n = nums.length;
        long[] prefixSum = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }
        return mergeSort(prefixSum, 0, n, lower, upper);
    }

    private int mergeSort(long[] prefixSum, int start, int end, int lower, int upper) {
        if (start >= end) return 0;
        int mid = start + (end - start) / 2;
        int count = mergeSort(prefixSum, start, mid, lower, upper) + mergeSort(prefixSum, mid + 1, end, lower, upper);

        int j = mid + 1, k = mid + 1;
        for (int i = start; i <= mid; i++) {
            while (j <= end && prefixSum[j] - prefixSum[i] < lower) j++;
            while (k <= end && prefixSum[k] - prefixSum[i] <= upper) k++;
            count += k - j;
        }

        Arrays.sort(prefixSum, start, end + 1);
        return count;
    }
}