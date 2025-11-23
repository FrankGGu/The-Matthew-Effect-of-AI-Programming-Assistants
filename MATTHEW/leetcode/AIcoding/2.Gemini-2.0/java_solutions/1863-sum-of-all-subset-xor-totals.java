class Solution {
    public int subsetXORSum(int[] nums) {
        int sum = 0;
        int n = nums.length;
        for (int i = 0; i < (1 << n); i++) {
            int xorSum = 0;
            for (int j = 0; j < n; j++) {
                if ((i >> j) % 2 == 1) {
                    xorSum ^= nums[j];
                }
            }
            sum += xorSum;
        }
        return sum;
    }
}