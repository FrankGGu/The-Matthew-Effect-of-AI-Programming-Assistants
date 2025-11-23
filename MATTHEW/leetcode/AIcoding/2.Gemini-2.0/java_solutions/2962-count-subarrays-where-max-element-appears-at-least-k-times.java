class Solution {
    public long countSubarrays(int[] nums, int k) {
        int maxVal = 0;
        for (int num : nums) {
            maxVal = Math.max(maxVal, num);
        }

        long count = 0;
        for (int i = 0; i < nums.length; i++) {
            int maxCount = 0;
            for (int j = i; j < nums.length; j++) {
                if (nums[j] == maxVal) {
                    maxCount++;
                }
                if (maxCount >= k) {
                    count++;
                }
            }
        }
        return count;
    }
}