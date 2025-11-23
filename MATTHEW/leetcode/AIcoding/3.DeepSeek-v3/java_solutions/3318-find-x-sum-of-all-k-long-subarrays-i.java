class Solution {
    public long getXSum(int[] nums, int k) {
        long sum = 0;
        int n = nums.length;
        for (int i = 0; i <= n - k; i++) {
            int xor = 0;
            for (int j = i; j < i + k; j++) {
                xor ^= nums[j];
            }
            sum += xor;
        }
        return sum;
    }
}