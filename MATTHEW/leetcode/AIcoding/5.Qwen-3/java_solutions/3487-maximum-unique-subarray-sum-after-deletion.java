public class Solution {

import java.util.*;

public class Solution {
    public int maximumUniqueSubarray(int[] nums) {
        int n = nums.length;
        int maxSum = 0;
        int left = 0;
        int currentSum = 0;
        Set<Integer> seen = new HashSet<>();

        for (int right = 0; right < n; right++) {
            while (seen.contains(nums[right])) {
                seen.remove(nums[left]);
                currentSum -= nums[left];
                left++;
            }
            seen.add(nums[right]);
            currentSum += nums[right];
            maxSum = Math.max(maxSum, currentSum);
        }

        return maxSum;
    }
}
}