class Solution {
    public int minOperations(int[] nums, int k) {
        int totalXOR = 0;
        for (int num : nums) {
            totalXOR ^= num;
        }
        int diff = totalXOR ^ k;
        return Integer.bitCount(diff);
    }
}