import java.util.Arrays;

class Solution {
    public int minOperations(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        int left = 0, right = 0, res = n;

        while (right < n) {
            while (right < n && nums[right] - nums[left] > n - 1) {
                left++;
            }
            res = Math.min(res, n - (right - left + 1));
            right++;
        }

        return res;
    }
}