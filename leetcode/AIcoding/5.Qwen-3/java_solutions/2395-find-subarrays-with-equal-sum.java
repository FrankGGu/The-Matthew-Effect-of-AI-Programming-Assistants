public class Solution {
    public boolean findSubarraysWithEqualSum(int[] nums) {
        int n = nums.length;
        for (int i = 0; i <= n - 3; i++) {
            int sum1 = nums[i] + nums[i + 1];
            int sum2 = nums[i + 1] + nums[i + 2];
            if (sum1 == sum2) {
                return true;
            }
        }
        return false;
    }
}