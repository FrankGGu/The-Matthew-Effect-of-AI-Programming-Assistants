class Solution {
    public int minimumLength(int[] nums) {
        int left = 0;
        int right = nums.length - 1;

        while (left < right && nums[left] == nums[right]) {
            int currentVal = nums[left];

            while (left <= right && nums[left] == currentVal) {
                left++;
            }

            while (left <= right && nums[right] == currentVal) {
                right--;
            }
        }

        return right - left + 1;
    }
}