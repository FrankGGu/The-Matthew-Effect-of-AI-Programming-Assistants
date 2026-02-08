import java.util.Arrays;

class Solution {
    public int smallestRangeII(int[] nums, int k) {
        Arrays.sort(nums);
        int n = nums.length;
        int ans = nums[n - 1] - nums[0];
        for (int i = 0; i < n - 1; i++) {
            int maxVal = Math.max(nums[n - 1] - k, nums[i] + k);
            int minVal = Math.min(nums[0] + k, nums[i + 1] - k);
            ans = Math.min(ans, maxVal - minVal);
        }
        return ans;
    }
}