class Solution {
    public int countElements(int[] nums) {
        int minVal = nums[0];
        int maxVal = nums[0];

        for (int i = 1; i < nums.length; i++) {
            if (nums[i] < minVal) {
                minVal = nums[i];
            }
            if (nums[i] > maxVal) {
                maxVal = nums[i];
            }
        }

        if (minVal == maxVal) {
            return 0;
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