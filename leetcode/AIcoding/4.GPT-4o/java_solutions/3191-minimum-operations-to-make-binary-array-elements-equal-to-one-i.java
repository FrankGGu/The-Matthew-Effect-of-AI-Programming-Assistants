class Solution {
    public int minOperations(int[] nums) {
        int countZero = 0;
        for (int num : nums) {
            if (num == 0) countZero++;
        }
        return Math.min(countZero, nums.length - countZero);
    }
}