import java.util.HashMap;
import java.util.Map;

class Solution {
    public long maximumSum(int[] nums, int m, int k) {
        long maxSum = 0;
        long currentSum = 0;
        Map<Integer, Integer> freqMap = new HashMap<>();

        for (int i = 0; i < nums.length; i++) {
            // Add current element to the window
            currentSum += nums[i];
            freqMap.put(nums[i], freqMap.getOrDefault(nums[i], 0) + 1);

            // If window size is k
            if (i >= k - 1) {
                // Check if the current window is "almost unique"
                if (freqMap.size() >= m) {
                    maxSum = Math.max(maxSum, currentSum);
                }

                // Remove the leftmost element from the window
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