import java.util.HashMap;

public class Solution {
    public int maximumUniqueSubarray(int[] nums) {
        HashMap<Integer, Integer> map = new HashMap<>();
        int left = 0, currentSum = 0, maxSum = 0;

        for (int right = 0; right < nums.length; right++) {
            if (map.containsKey(nums[right])) {
                left = Math.max(left, map.get(nums[right]) + 1);
            }
            map.put(nums[right], right);
            currentSum = right - left + 1;
            maxSum = Math.max(maxSum, currentSum);
        }

        return maxSum;
    }
}