import java.util.HashMap;
import java.util.Map;

class Solution {
    public long maximumSubarraySum(int[] nums, int k) {
        long maxSum = 0;
        long currentSum = 0;
        Map<Integer, Integer> freqMap = new HashMap<>();

        for (int i = 0; i < nums.length; i++) {
            currentSum += nums[i];
            freqMap.put(nums[i], freqMap.getOrDefault(nums[i], 0) + 1);

            if (i >= k - 1) {
                if (freqMap.size() == k) {
                    maxSum = Math.max(maxSum, currentSum);
                }

                int leftElement = nums[i - k + 1];
                currentSum -= leftElement;
                freqMap.put(leftElement, freqMap.get(leftElement) - 1);
                if (freqMap.get(leftElement) == 0) {
                    freqMap.remove(leftElement);
                }
            }
        }

        return maxSum;
    }
}