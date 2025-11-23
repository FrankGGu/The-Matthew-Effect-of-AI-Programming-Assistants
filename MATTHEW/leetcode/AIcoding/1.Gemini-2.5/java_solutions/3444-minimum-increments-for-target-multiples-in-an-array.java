class Solution {
    public long minIncrements(int[] nums, int k) {
        long totalIncrements = 0;
        for (int num : nums) {
            if (num % k != 0) {
                totalIncrements += (k - (num % k));
            }
        }
        return totalIncrements;
    }
}