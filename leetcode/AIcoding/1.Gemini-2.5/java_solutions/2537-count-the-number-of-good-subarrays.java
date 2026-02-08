import java.util.HashMap;
import java.util.Map;

class Solution {
    public long goodSubarrays(int[] nums, int k) {
        return countAtMost(nums, k) - countAtMost(nums, k - 1);
    }

    private long countAtMost(int[] nums, int targetK) {
        if (targetK < 0) {
            return 0;
        }

        long count = 0;
        int left = 0;
        long currentPairs = 0;
        Map<Integer, Integer> freq = new HashMap<>();

        for (int right = 0; right < nums.length; right++) {
            int numR = nums[right];
            currentPairs += freq.getOrDefault(numR, 0);
            freq.put(numR, freq.getOrDefault(numR, 0) + 1);

            while (currentPairs > targetK) {
                int numL = nums[left];
                freq.put(numL, freq.get(numL) - 1);
                currentPairs -= freq.get(numL); // Subtract pairs numL formed with remaining numL's
                left++;
            }
            count += (right - left + 1);
        }
        return count;
    }
}