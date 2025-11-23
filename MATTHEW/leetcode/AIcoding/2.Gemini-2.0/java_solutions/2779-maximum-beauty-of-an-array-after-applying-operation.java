import java.util.Arrays;

class Solution {
    public int maximumBeauty(int[] nums, int k) {
        Arrays.sort(nums);
        int left = 0;
        int right = 0;
        int maxBeauty = 0;
        while (right < nums.length) {
            if (nums[right] - nums[left] <= 2 * k) {
                maxBeauty = Math.max(maxBeauty, right - left + 1);
                right++;
            } else {
                left++;
            }
        }
        return maxBeauty;
    }
}