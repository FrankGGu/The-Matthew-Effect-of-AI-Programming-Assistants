class Solution {
    public int numberOfGoodSubarraySplits(int[] nums) {
        int n = nums.length;
        int firstOne = -1;
        for (int i = 0; i < n; i++) {
            if (nums[i] == 1) {
                firstOne = i;
                break;
            }
        }
        if (firstOne == -1) {
            return 0;
        }

        long ans = 1;
        int prev = firstOne;
        int mod = 1000000007;

        for (int i = firstOne + 1; i < n; i++) {
            if (nums[i] == 1) {
                ans = (ans * (i - prev)) % mod;
                prev = i;
            }
        }

        return (int) ans;
    }
}