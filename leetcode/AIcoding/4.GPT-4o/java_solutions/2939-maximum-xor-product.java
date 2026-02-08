class Solution {
    public int maximumXor(int[] nums) {
        int maxXor = 0;
        for (int num : nums) {
            maxXor |= num;
        }
        return maxXor;
    }
}