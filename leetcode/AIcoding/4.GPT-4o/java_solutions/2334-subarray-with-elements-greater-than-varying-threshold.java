class Solution {
    public int countSubarrays(int[] nums, int threshold) {
        int count = 0;
        int left = 0;
        for (int right = 0; right < nums.length; right++) {
            if (nums[right] <= threshold) {
                count += right - left + 1;
            } else {
                left = right + 1;
            }
        }
        return count;
    }
}