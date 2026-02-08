class Solution {
    private static final int MOD = 1000000007;

    public int sumOfTotalStrength(int[] strength) {
        int n = strength.length;
        long[] prefixSum = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = (prefixSum[i] + strength[i]) % MOD;
        }

        int[] left = new int[n];
        int[] right = new int[n];
        for (int i = 0; i < n; i++) {
            left[i] = i;
            while (left[i] > 0 && strength[left[i] - 1] >= strength[i]) {
                left[i] = left[left[i] - 1];
            }
        }
        for (int i = n - 1; i >= 0; i--) {
            right[i] = i;
            while (right[i] < n - 1 && strength[right[i] + 1] > strength[i]) {
                right[i] = right[right[i] + 1];
            }
        }

        long result = 0;
        for (int i = 0; i < n; i++) {
            int l = left[i];
            int r = right[i];

            long leftInterval = (i - l + 1);
            long rightInterval = (r - i + 1);

            long sumLeft = (prefixSum[i + 1] - prefixSum[l] + MOD) % MOD;
            long sumRight = (prefixSum[r + 1] - prefixSum[i + 1] + MOD) % MOD;

            long totalSum = ((rightInterval * sumLeft) % MOD - (leftInterval * sumRight) % MOD + MOD) % MOD;

            result = (result + (strength[i] * totalSum) % MOD) % MOD;
        }

        return (int) result;
    }
}