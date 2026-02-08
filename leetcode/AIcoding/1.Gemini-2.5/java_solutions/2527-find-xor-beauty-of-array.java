class Solution {
    public int xorBeauty(int[] nums) {
        int xorSum = 0;
        for (int num : nums) {
            xorSum ^= num;
        }
        return xorSum;
    }
}