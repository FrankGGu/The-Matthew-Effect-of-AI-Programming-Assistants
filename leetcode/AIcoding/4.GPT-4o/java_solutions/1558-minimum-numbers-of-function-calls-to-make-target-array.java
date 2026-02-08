class Solution {
    public int minOperations(int[] nums) {
        int maxNum = 0, operations = 0;
        for (int num : nums) {
            maxNum = Math.max(maxNum, num);
            operations += Integer.bitCount(num);
        }
        return operations + Integer.bitCount(maxNum);
    }
}