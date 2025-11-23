class Solution {
    public int maximumXOR(int[] nums) {
        int orSum = 0;
        for (int num : nums) {
            orSum |= num;
        }
        return orSum;
    }
}