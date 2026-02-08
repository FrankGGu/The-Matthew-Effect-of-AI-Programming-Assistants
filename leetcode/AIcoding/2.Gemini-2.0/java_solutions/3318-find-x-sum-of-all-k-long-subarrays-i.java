class Solution {
    public int subarrayXor(int[] nums, int k) {
        int n = nums.length;
        int count = 0;
        for (int i = 0; i <= n - k; i++) {
            int xorSum = 0;
            for (int j = i; j < i + k; j++) {
                xorSum ^= nums[j];
            }
            if (xorSum == k) {
                count++;
            }
        }
        return count;
    }
}