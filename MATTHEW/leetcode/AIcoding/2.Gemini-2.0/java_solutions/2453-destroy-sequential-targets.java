import java.util.HashMap;
import java.util.Map;

class Solution {
    public int destroyTargets(int[] nums, int space) {
        Map<Integer, Integer> remainderCount = new HashMap<>();
        int maxCount = 0;
        for (int num : nums) {
            int remainder = num % space;
            remainderCount.put(remainder, remainderCount.getOrDefault(remainder, 0) + 1);
            maxCount = Math.max(maxCount, remainderCount.get(remainder));
        }

        int minNum = Integer.MAX_VALUE;
        for (int num : nums) {
            if (remainderCount.get(num % space) == maxCount) {
                minNum = Math.min(minNum, num);
                remainderCount.put(num % space, 0);
            }
        }

        return minNum;
    }
}