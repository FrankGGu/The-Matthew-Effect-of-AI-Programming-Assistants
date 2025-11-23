class Solution {
    public int subsetXORSum(int[] nums) {
        int overallBitwiseOR = 0;
        for (int num : nums) {
            overallBitwiseOR |= num;
        }

        return overallBitwiseOR * (1 << (nums.length - 1));
    }
}