import java.util.Arrays;

class Solution {
    public int maxFrequencyScore(int[] nums, int k) {
        Arrays.sort(nums);
        int n = nums.length;
        int left = 0;
        int ans = 0;
        long sum = 0;
        for (int right = 0; right < n; right++) {
            sum += nums[right];
            while ((long) nums[right] * (right - left + 1) - sum > k) {
                sum -= nums[left];
                left++;
            }
            ans = Math.max(ans, right - left + 1);
        }
        return ans;
    }
}