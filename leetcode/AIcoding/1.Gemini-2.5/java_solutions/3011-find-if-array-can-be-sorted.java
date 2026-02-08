import java.util.Arrays;

class Solution {
    public boolean canBeSorted(int[] nums) {
        if (nums.length <= 1) {
            return true;
        }

        int start = 0;
        for (int i = 0; i < nums.length; i++) {
            if (i > 0 && Integer.bitCount(nums[i]) != Integer.bitCount(nums[i - 1])) {
                Arrays.sort(nums, start, i);
                start = i;
            }
        }
        // Sort the last segment
        Arrays.sort(nums, start, nums.length);

        // Check if the entire array is sorted
        for (int i = 0; i < nums.length - 1; i++) {
            if (nums[i] > nums[i + 1]) {
                return false;
            }
        }

        return true;
    }
}