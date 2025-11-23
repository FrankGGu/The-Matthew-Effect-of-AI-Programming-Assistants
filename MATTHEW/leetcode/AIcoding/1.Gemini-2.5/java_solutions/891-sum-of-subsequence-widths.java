import java.util.Arrays;

class Solution {
    public int sumSubseqWidths(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        long ans = 0;
        long MOD = 1_000_000_007;

        long[] pow2 = new long[n];
        pow2[0] = 1;
        for (int i = 1; i < n; i++) {
            pow2[i] = (pow2[i - 1] * 2) % MOD;
        }

        for (int i = 0; i < n; i++) {
            // Contribution of nums[i] as a maximum element in subsequences
            // There are i elements smaller than nums[i]. Each can be included or not (2^i ways).
            long maxContribution = (nums[i] * pow2[i]) % MOD;

            // Contribution of nums[i] as a minimum element in subsequences
            // There are (n - 1 - i) elements larger than nums[i]. Each can be included or not (2^(n-1-i) ways).
            long minContribution = (nums[i] * pow2[n - 1 - i]) % MOD;

            // The total sum is sum(max_element - min_element) over all subsequences.
            // This is equivalent to sum(nums[i] * (count_as_max - count_as_min))
            ans = (ans + maxContribution - minContribution + MOD) % MOD;
        }

        return (int) ans;
    }
}