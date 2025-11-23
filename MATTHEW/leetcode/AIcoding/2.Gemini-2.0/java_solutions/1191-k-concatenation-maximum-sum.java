class Solution {
    public int kConcatenationMaxSum(int[] arr, int k) {
        long mod = 1000000007;
        long kadaneSum = kadane(arr);
        if (k == 1) {
            return (int) (kadaneSum % mod);
        }

        long sum = 0;
        for (int num : arr) {
            sum += num;
        }

        if (sum > 0) {
            long maxPrefixSum = 0, currentPrefixSum = 0;
            for (int num : arr) {
                currentPrefixSum += num;
                maxPrefixSum = Math.max(maxPrefixSum, currentPrefixSum);
            }

            long maxSuffixSum = 0, currentSuffixSum = 0;
            for (int i = arr.length - 1; i >= 0; i--) {
                currentSuffixSum += arr[i];
                maxSuffixSum = Math.max(maxSuffixSum, currentSuffixSum);
            }

            long result = (kadaneSum + (k - 2) * sum + maxPrefixSum + maxSuffixSum) % mod;
            return (int) Math.max(kadaneSum,result);
        } else {
            long maxPrefixSum = 0, currentPrefixSum = 0;
            for (int num : arr) {
                currentPrefixSum += num;
                maxPrefixSum = Math.max(maxPrefixSum, currentPrefixSum);
            }

            long maxSuffixSum = 0, currentSuffixSum = 0;
            for (int i = arr.length - 1; i >= 0; i--) {
                currentSuffixSum += arr[i];
                maxSuffixSum = Math.max(maxSuffixSum, currentSuffixSum);
            }
            long result = (maxPrefixSum + maxSuffixSum) % mod;
            return (int) Math.max(kadaneSum, result);

        }
    }

    private long kadane(int[] arr) {
        long maxSoFar = 0;
        long currentMax = 0;
        long mod = 1000000007;

        for (int num : arr) {
            currentMax = Math.max(0, currentMax + num);
            maxSoFar = Math.max(maxSoFar, currentMax);
        }
        return maxSoFar % mod;
    }
}