class Solution {
    public int minOperations(int[] arr, int k) {
        int n = arr.length;
        int[] dp = new int[n];
        int len = 0;

        for (int i = 0; i < n; i++) {
            if (i > 0 && arr[i] - arr[i - 1] > k) {
                len = 0;
            }
            int pos = binarySearch(dp, len, arr[i]);
            dp[pos] = arr[i];
            if (pos == len) len++;
        }
        return n - len;
    }

    private int binarySearch(int[] dp, int len, int target) {
        int left = 0, right = len;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (dp[mid] <= target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }
}