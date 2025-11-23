class Solution {
    public int minOperations(int[] nums, int k) {
        int currentXOR = 0;
        for (int num : nums) {
            currentXOR ^= num;
        }

        int diff = currentXOR ^ k;

        return Integer.bitCount(diff);
    }
}