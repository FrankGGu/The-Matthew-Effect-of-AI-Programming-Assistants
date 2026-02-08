import java.util.HashMap;
import java.util.Map;

class Solution {
    public int maxFrequencyScore(int[] nums) {
        Map<Integer, Integer> evenFreq = new HashMap<>();
        Map<Integer, Integer> oddFreq = new HashMap<>();

        for (int i = 0; i < nums.length; i++) {
            if (i % 2 == 0) {
                evenFreq.put(nums[i], evenFreq.getOrDefault(nums[i], 0) + 1);
            } else {
                oddFreq.put(nums[i], oddFreq.getOrDefault(nums[i], 0) + 1);
            }
        }

        int maxDiff = Integer.MIN_VALUE;
        for (int num : nums) {
            int evenCount = evenFreq.getOrDefault(num, 0);
            int oddCount = oddFreq.getOrDefault(num, 0);
            maxDiff = Math.max(maxDiff, evenCount - oddCount);
        }

        return maxDiff;
    }
}