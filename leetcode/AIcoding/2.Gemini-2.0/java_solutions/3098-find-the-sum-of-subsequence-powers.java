import java.util.Arrays;

class Solution {
    private static final int MOD = 1000000007;

    public int sumOfPower(int[] nums) {
        Arrays.sort(nums);
        long sum = 0;
        long prefixSum = 0;
        for (int num : nums) {
            sum = (sum + (long) num * num % MOD * (num + prefixSum)) % MOD;
            prefixSum = (2 * prefixSum + num) % MOD;
        }
        return (int) sum;
    }
}