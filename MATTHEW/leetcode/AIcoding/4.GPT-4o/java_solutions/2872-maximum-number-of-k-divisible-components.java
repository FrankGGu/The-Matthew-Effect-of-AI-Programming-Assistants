class Solution {
    public int maxKDivisibleComponents(int[] nums, int k) {
        int count = 0;
        for (int num : nums) {
            if (num % k == 0) {
                count++;
            }
        }
        return count;
    }
}