class Solution {
    public int continuousSubarrays(int[] nums) {
        int n = nums.length;
        int count = 0;
        int left = 0;
        int max = nums[0];
        int min = nums[0];

        for (int right = 0; right < n; right++) {
            max = Math.max(max, nums[right]);
            min = Math.min(min, nums[right]);

            while (max - min > 2) {
                left++;
                max = Integer.MIN_VALUE;
                min = Integer.MAX_VALUE;
                for (int i = left; i <= right; i++) {
                    max = Math.max(max, nums[i]);
                    min = Math.min(min, nums[i]);
                }
            }
            count += right - left + 1;
        }

        return count;
    }
}