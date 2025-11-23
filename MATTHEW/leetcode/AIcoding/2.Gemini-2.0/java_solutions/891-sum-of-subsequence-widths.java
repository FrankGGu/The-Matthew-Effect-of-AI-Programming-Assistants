import java.util.Arrays;

class Solution {
    public int sumSubseqWidths(int[] nums) {
        int MOD = 1_000_000_007;
        Arrays.sort(nums);
        long ans = 0;
        long p = 1;
        for (int i = 0; i < nums.length; ++i) {
            ans = (ans + (nums[i] - nums[nums.length - 1 - i]) * p) % MOD;
            p = (p * 2) % MOD;
        }
        return (int) ans;
    }
}