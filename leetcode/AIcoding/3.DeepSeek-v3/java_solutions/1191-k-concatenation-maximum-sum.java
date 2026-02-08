class Solution {
    public int kConcatenationMaxSum(int[] arr, int k) {
        int mod = 1000000007;
        long maxPrefix = 0, maxSuffix = 0, total = 0;
        long currentPrefix = 0, currentSuffix = 0;
        int n = arr.length;

        for (int i = 0; i < n; i++) {
            currentPrefix += arr[i];
            maxPrefix = Math.max(maxPrefix, currentPrefix);
        }
        total = currentPrefix;

        for (int i = n - 1; i >= 0; i--) {
            currentSuffix += arr[i];
            maxSuffix = Math.max(maxSuffix, currentSuffix);
        }

        long maxSubarray = 0;
        long current = 0;
        for (int num : arr) {
            current = Math.max(num, current + num);
            maxSubarray = Math.max(maxSubarray, current);
        }

        if (k == 1) {
            return (int) (maxSubarray % mod);
        }

        long sum = Math.max(maxPrefix + maxSuffix, maxSubarray);
        if (total > 0) {
            sum = Math.max(sum, maxPrefix + maxSuffix + total * (k - 2));
        }

        return (int) (sum % mod < 0 ? 0 : sum % mod);
    }
}