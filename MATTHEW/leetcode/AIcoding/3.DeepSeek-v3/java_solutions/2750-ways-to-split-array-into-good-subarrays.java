class Solution {
    public int numberOfGoodSubarraySplits(int[] nums) {
        int mod = 1000000007;
        long result = 1;
        int prevOne = -1;
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] == 1) {
                if (prevOne != -1) {
                    result = (result * (i - prevOne)) % mod;
                }
                prevOne = i;
            }
        }
        return prevOne == -1 ? 0 : (int) result;
    }
}