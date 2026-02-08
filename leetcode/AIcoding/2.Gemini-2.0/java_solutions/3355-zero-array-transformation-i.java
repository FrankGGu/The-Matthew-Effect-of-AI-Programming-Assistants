class Solution {
    public boolean canConvert(int[] nums) {
        int n = nums.length;
        int nonZeroCount = 0;
        for (int num : nums) {
            if (num != 0) {
                nonZeroCount++;
            }
        }
        return nonZeroCount <= n / 2;
    }
}