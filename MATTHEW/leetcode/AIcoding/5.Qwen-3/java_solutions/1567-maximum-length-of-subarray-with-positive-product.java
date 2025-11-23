public class Solution {
    public int maxLen(int[] nums) {
        int n = nums.length;
        int positive = 0, negative = 0;
        int maxLen = 0;

        for (int i = 0; i < n; i++) {
            if (nums[i] > 0) {
                positive++;
                negative++;
            } else if (nums[i] < 0) {
                int temp = positive;
                positive = negative + 1;
                negative = temp + 1;
            } else {
                positive = 0;
                negative = 0;
            }

            if (positive > maxLen) {
                maxLen = positive;
            }
        }

        return maxLen;
    }
}