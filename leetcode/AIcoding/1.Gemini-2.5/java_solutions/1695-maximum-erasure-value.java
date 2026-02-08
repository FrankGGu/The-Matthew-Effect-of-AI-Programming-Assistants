import java.util.HashSet;
import java.util.Set;

class Solution {
    public int maximumUniqueSubarray(int[] nums) {
        int maxSum = 0;
        int currentSum = 0;
        Set<Integer> uniqueElements = new HashSet<>();
        int left = 0;

        for (int right = 0; right < nums.length; right++) {
            while (uniqueElements.contains(nums[right])) {
                currentSum -= nums[left];
                uniqueElements.remove(nums[left]);
                left++;
            }
            currentSum += nums[right];
            uniqueElements.add(nums[right]);
            maxSum = Math.max(maxSum, currentSum);
        }

        return maxSum;
    }
}