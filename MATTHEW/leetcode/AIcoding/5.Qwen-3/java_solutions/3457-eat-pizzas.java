public class Solution {

import java.util.*;

public class Solution {
    public int minOperations(int[] nums, int x) {
        int total = Arrays.stream(nums).sum();
        int n = nums.length;
        int target = total - x;
        if (target < 0) return -1;
        if (target == 0) return n;

        int maxLen = -1;
        int currentSum = 0;
        int left = 0;

        for (int right = 0; right < n; right++) {
            currentSum += nums[right];
            while (currentSum > target && left <= right) {
                currentSum -= nums[left];
                left++;
            }
            if (currentSum == target) {
                maxLen = Math.max(maxLen, right - left + 1);
            }
        }

        return maxLen == -1 ? -1 : n - maxLen;
    }
}
}