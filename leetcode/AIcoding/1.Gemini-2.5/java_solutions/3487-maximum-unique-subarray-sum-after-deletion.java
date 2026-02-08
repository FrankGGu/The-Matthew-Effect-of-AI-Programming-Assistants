import java.util.HashSet;
import java.util.Set;

class Solution {
    public int maximumUniqueSubarray(int[] nums) {
        int maxSum = 0;
        int currentSum = 0;
        Set<Integer> seen = new HashSet<>();
        int left = 0;

        for (int right = 0; right < nums.length; right++) {
            while (seen.contains(nums[right])) {
                currentSum -= nums[left];
                seen.remove(nums[left]);
                left++;
            }
            currentSum += nums[right];
            seen.add(nums[right]);
            maxSum = Math.max(maxSum, currentSum);
        }

        return maxSum;
    }
}