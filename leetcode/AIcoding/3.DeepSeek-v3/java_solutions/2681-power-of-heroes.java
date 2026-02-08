class Solution {
    public int sumOfPower(int[] nums) {
        final int MOD = 1_000_000_007;
        Arrays.sort(nums);
        long sum = 0;
        long pre = 0;
        for (long num : nums) {
            long square = (num * num) % MOD;
            sum = (sum + square * num % MOD) % MOD;
            sum = (sum + square * pre % MOD) % MOD;
            pre = (pre * 2 + num) % MOD;
        }
        return (int) sum;
    }
}