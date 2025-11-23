class Solution {
    public int countElements(int[] nums) {
        if (nums == null || nums.length <= 2) {
            return 0;
        }

        int minVal = nums[0];
        int maxVal = nums[0];

        for (int num : nums) {
            minVal = Math.min(minVal, num);
            maxVal = Math.max(maxVal, num);
        }

        int count = 0;
        for (int num : nums) {
            if (num > minVal && num < maxVal) {
                count++;
            }
        }

        return count;
    }
}