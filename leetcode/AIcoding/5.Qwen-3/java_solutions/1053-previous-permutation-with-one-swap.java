public class Solution {
    public int[] prevPermOpt1(int[] nums) {
        int n = nums.length;
        int i = n - 2;
        while (i >= 0 && nums[i] <= nums[i + 1]) {
            i--;
        }
        if (i < 0) {
            return nums;
        }
        int j = n - 1;
        while (nums[j] >= nums[i]) {
            j--;
        }
        while (j > i && nums[j] == nums[j - 1]) {
            j--;
        }
        int temp = nums[i];
        nums[i] = nums[j];
        nums[j] = temp;
        return nums;
    }
}