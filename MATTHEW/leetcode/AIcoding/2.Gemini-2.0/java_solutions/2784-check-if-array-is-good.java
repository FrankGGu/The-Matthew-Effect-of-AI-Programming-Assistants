import java.util.Arrays;

class Solution {
    public boolean isGood(int[] nums) {
        int n = nums.length;
        Arrays.sort(nums);
        if (nums[n - 1] != n - 1) {
            return false;
        }
        for (int i = 0; i < n - 1; i++) {
            if (nums[i] != i + 1) {
                return false;
            }
        }
        if (nums[n - 2] != n - 1) {
            return false;
        }
        return true;
    }
}