import java.util.Arrays;

public class Solution {
    public int minOperations(int[] nums, int x) {
        int total = Arrays.stream(nums).sum();
        int target = total - x, maxLength = -1;
        int sum = 0;
        int left = 0;

        for (int right = 0; right < nums.length; right++) {
            sum += nums[right];
            while (sum > target && left <= right) {
                sum -= nums[left++];
            }
            if (sum == target) {
                maxLength = Math.max(maxLength, right - left + 1);
            }
        }

        return maxLength == -1 ? -1 : nums.length - maxLength;
    }
}