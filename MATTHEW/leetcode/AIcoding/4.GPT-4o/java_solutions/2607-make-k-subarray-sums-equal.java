class Solution {
    public boolean canMakeKSubarraySumsEqual(int[] arr, int k) {
        int n = arr.length;
        if (n % k != 0) return false;

        long totalSum = 0;
        for (int num : arr) totalSum += num;

        if (totalSum % k != 0) return false;
        long targetSum = totalSum / k;

        return canPartition(arr, 0, new long[k], targetSum);
    }

    private boolean canPartition(int[] arr, int index, long[] sums, long target) {
        if (index == arr.length) {
            for (long sum : sums) {
                if (sum != target) return false;
            }
            return true;
        }

        for (int i = 0; i < sums.length; i++) {
            if (sums[i] + arr[index] <= target) {
                sums[i] += arr[index];
                if (canPartition(arr, index + 1, sums, target)) return true;
                sums[i] -= arr[index];
            }
            if (sums[i] == 0) break; // Optimization to prevent redundant checks
        }

        return false;
    }
}