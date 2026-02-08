class Solution {
    public int maximumXOR(int[] nums) {
        int maxXOR = 0;
        for (int num : nums) {
            maxXOR |= num;
        }
        return maxXOR;
    }
}