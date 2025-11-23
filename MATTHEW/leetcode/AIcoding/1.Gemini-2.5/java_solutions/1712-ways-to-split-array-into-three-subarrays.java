class Solution {
    public int waysToSplit(int[] nums) {
        int n = nums.length;
        if (n < 3) {
            return 0;
        }

        long[] prefixSum = new long[n];
        prefixSum[0] = nums[0];
        for (int k = 1; k < n; k++) {
            prefixSum[k] = prefixSum[k - 1] + nums[k];
        }

        long totalSum = prefixSum[n - 1];
        int count = 0;
        int MOD = 1_000_000_007;

        int j_start = 1; 
        int j_end = 1;   

        for (int i = 0; i < n - 2; i++) {
            long sum1 = prefixSum[i];

            j_start = Math.max(j_start, i + 1);
            while (j_start <= n - 2 && 2 * sum1 > prefixSum[j_start]) {
                j_start++;
            }

            if (j_start > n - 2) {
                break; 
            }

            j_end = Math.max(j_end, j_start);
            while (j_end <= n - 2 && 2 * prefixSum[j_end] <= totalSum + sum1) {
                j_end++;
            }

            if (j_end - 1 >= j_start) {
                count = (count + (j_end - 1 - j_start + 1)) % MOD;
            }
        }

        return count;
    }
}