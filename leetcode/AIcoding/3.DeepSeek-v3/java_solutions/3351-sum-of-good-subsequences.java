import java.util.Arrays;

class Solution {
    public int sumOfPower(int[] nums) {
        int MOD = 1_000_000_007;
        Arrays.sort(nums);
        long res = 0;
        long preSum = 0;
        for (long num : nums) {
            res = (res + (num * num % MOD) * num % MOD) % MOD;
            res = (res + (num * num % MOD) * preSum % MOD) % MOD;
            preSum = (preSum * 2 + num) % MOD;
        }
        return (int) res;
    }
}