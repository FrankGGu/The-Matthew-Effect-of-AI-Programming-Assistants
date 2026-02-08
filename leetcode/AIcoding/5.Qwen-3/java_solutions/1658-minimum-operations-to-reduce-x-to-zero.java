public class Solution {

import java.util.*;

public class Solution {
    public int minOperations(int[] nums, int x) {
        int total = 0;
        for (int num : nums) {
            total += num;
        }
        int target = total - x;
        if (target < 0) return -1;
        if (target == 0) return nums.length;

        Map<Integer, Integer> prefixSum = new HashMap<>();
        prefixSum.put(0, -1);
        int currentSum = 0;
        int maxLength = -1;

        for (int i = 0; i < nums.length; i++) {
            currentSum += nums[i];
            if (prefixSum.containsKey(currentSum - target)) {
                maxLength = Math.max(maxLength, i - prefixSum.get(currentSum - target));
            }
            if (!prefixSum.containsKey(currentSum)) {
                prefixSum.put(currentSum, i);
            }
        }

        return maxLength == -1 ? -1 : nums.length - maxLength;
    }
}
}