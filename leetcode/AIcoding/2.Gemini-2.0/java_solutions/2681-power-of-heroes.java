class Solution {
    private static final int MOD = 1000000007;

    public int sumOfPower(int[] nums) {
        Arrays.sort(nums);
        long ans = 0;
        long sum = 0;
        for (int num : nums) {
            ans = (ans + (long) num * num % MOD * (num + sum) % MOD) % MOD;
            sum = (sum * 2 % MOD + num) % MOD;
        }
        return (int) ans;
    }
}