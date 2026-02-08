class Solution {
    public boolean canMakeSubarraySumsZero(int[] nums) {
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }
        return sum == 0;
    }
}