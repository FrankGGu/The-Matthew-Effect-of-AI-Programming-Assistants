import java.util.*;

class Solution {
    public int minOperations(int[] nums, int x) {
        int total = Arrays.stream(nums).sum();
        int target = total - x;
        if (target < 0) return -1;

        int maxLen = -1;
        int currentSum = 0;
        Map<Integer, Integer> sumMap = new HashMap<>();
        sumMap.put(0, -1);

        for (int i = 0; i < nums.length; i++) {
            currentSum += nums[i];
            if (sumMap.containsKey(currentSum - target)) {
                maxLen = Math.max(maxLen, i - sumMap.get(currentSum - target));
            }
            sumMap.put(currentSum, i);
        }

        return maxLen == -1 ? -1 : nums.length - maxLen;
    }
}