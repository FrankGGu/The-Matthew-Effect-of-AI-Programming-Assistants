class Solution {
    public int maximumBeauty(int[] nums, int k) {
        Arrays.sort(nums);
        int maxBeauty = 0;
        for (int i = 0; i < nums.length; i++) {
            int left = nums[i] - k;
            int right = nums[i] + k;
            int count = 0;
            for (int num : nums) {
                if (num >= left && num <= right) {
                    count++;
                }
            }
            maxBeauty = Math.max(maxBeauty, count);
        }
        return maxBeauty;
    }
}