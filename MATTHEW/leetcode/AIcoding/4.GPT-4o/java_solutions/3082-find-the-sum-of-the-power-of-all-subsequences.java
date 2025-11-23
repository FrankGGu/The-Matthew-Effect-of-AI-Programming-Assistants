class Solution {
    public int sumOfPowers(int[] nums) {
        long mod = 1000000007;
        long totalSum = 0;
        long n = nums.length;

        for (int i = 0; i < n; i++) {
            long power = 1;
            for (int j = 0; j < n; j++) {
                if (i != j) {
                    power = (power * (nums[j] + 1)) % mod;
                }
            }
            totalSum = (totalSum + (power * nums[i]) % mod) % mod;
        }

        return (int) totalSum;
    }
}