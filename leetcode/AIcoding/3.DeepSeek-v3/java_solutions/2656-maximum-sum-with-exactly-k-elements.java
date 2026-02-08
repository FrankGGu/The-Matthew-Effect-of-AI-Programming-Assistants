class Solution {
    public int maximizeSum(int[] nums, int k) {
        int max = 0;
        for (int num : nums) {
            if (num > max) {
                max = num;
            }
        }
        return k * max + k * (k - 1) / 2;
    }
}