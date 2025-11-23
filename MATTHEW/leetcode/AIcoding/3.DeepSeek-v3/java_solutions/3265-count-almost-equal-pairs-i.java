class Solution {
    public int countAlmostEqualPairs(int[] nums) {
        int count = 0;
        int n = nums.length;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if (Math.abs(nums[i] - nums[j]) <= 2) {
                    count++;
                }
            }
        }
        return count;
    }
}