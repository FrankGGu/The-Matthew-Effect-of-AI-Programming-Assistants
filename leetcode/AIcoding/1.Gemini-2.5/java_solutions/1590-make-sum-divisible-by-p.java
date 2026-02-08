import java.util.HashMap;
import java.util.Map;

class Solution {
    public int minSubarray(int[] nums, int p) {
        long totalSum = 0;
        for (int num : nums) {
            totalSum += num;
        }

        int remainderNeeded = (int) (totalSum % p);

        if (remainderNeeded == 0) {
            return 0;
        }

        Map<Integer, Integer> remainderMap = new HashMap<>();
        remainderMap.put(0, -1); 

        int currentRemainder = 0;
        int minLen = nums.length;

        for (int i = 0; i < nums.length; i++) {
            currentRemainder = (currentRemainder + nums[i]) % p;

            int targetRemainder = (currentRemainder - remainderNeeded + p) % p;

            if (remainderMap.containsKey(targetRemainder)) {
                minLen = Math.min(minLen, i - remainderMap.get(targetRemainder));
            }
            remainderMap.put(currentRemainder, i);
        }

        if (minLen == nums.length) {
            return -1;
        }
        return minLen;
    }
}