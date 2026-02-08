class Solution {
    public int minOperations(int[] nums, int k) {
        int currentXorSum = 0;
        for (int num : nums) {
            currentXorSum ^= num;
        }

        int targetDiff = currentXorSum ^ k;

        return Integer.bitCount(targetDiff);
    }
}