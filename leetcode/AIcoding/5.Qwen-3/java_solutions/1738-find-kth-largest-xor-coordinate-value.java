public class Solution {
    public int kthLargestNumber(int[] nums, int k) {
        java.util.Arrays.sort(nums);
        return nums[nums.length - k];
    }
}