import java.util.HashMap;
import java.util.Map;

class Solution {
    public long maximumSum(int[] nums, int k) {
        int left = 0;
        long currentSum = 0;
        long maxSum = 0;
        Map<Integer, Integer> counts = new HashMap<>();

        for (int right = 0; right < nums.length; right++) {
            int currentNum = nums[right];
            counts.put(currentNum, counts.getOrDefault(currentNum, 0) + 1);
            currentSum += currentNum;

            while (counts.get(currentNum) > k) {
                int leftNum = nums[left];
                counts.put(leftNum, counts.get(leftNum) - 1);
                currentSum -= leftNum;
                left++;
            }
            maxSum = Math.max(maxSum, currentSum);
        }
        return maxSum;
    }
}