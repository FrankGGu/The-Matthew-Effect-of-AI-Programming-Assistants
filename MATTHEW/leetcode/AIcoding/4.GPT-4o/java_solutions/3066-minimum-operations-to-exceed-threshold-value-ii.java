import java.util.*;

class Solution {
    public int minOperations(int[] nums, int x) {
        int total = Arrays.stream(nums).sum();
        int target = total - x;

        if (target < 0) return -1;

        Map<Integer, Integer> map = new HashMap<>();
        map.put(0, -1);
        int maxLength = -1, currentSum = 0;

        for (int i = 0; i < nums.length; i++) {
            currentSum += nums[i];
            if (map.containsKey(currentSum - target)) {
                maxLength = Math.max(maxLength, i - map.get(currentSum - target));
            }
            map.put(currentSum, i);
        }

        return maxLength == -1 ? -1 : nums.length - maxLength;
    }
}