class Solution {
    public boolean xorGame(int[] nums) {
        int xorSum = 0;
        for (int num : nums) {
            xorSum ^= num;
        }

        // Alice wins if the XOR sum of all elements is 0,
        // or if the number of elements is even.
        // Otherwise, Alice loses.
        return xorSum == 0 || nums.length % 2 == 0;
    }
}