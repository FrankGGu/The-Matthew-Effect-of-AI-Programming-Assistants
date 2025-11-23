public class Solution {
    public int kItemsWithMaximumSum(int[] nums, int k, int n) {
        int sum = 0;
        for (int i = 0; i < k && i < nums.length; i++) {
            sum += nums[i];
        }
        return sum;
    }
}