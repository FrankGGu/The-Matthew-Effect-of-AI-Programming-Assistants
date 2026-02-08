class Solution {
    public int sumOfPower(int[] nums) {
        final int MOD = 1_000_000_007;
        Arrays.sort(nums);
        long sum = 0;
        long prev = 0;
        for (int i = 0; i < nums.length; i++) {
            long current = (long) nums[i] * nums[i] % MOD;
            current = current * (prev + 1) % MOD;
            sum = (sum + current) % MOD;
            prev = (prev * 2 + 1) % MOD;
        }
        return (int) sum;
    }
}