class Solution {
    private static final int MOD = 1000000007;

    public int sumSubseqWidths(int[] nums) {
        Arrays.sort(nums);
        long ans = 0;
        long pow = 1;
        for (int i = 0; i < nums.length; i++) {
            ans = (ans + (nums[i] - nums[nums.length - 1 - i]) * pow) % MOD;
            pow = (pow * 2) % MOD;
        }
        return (int) ((ans + MOD) % MOD);
    }
}